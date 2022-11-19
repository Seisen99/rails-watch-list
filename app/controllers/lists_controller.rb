# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :search_movie, only: %i[index show new create]
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @movies = Movie.all.sort_by(&:title)
    @bookmarks = Bookmark.all
    @@bookmark = @bookmark
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def search_movie
    if params[:query].present?
      @query = params[:query]
      @movies = Movie.search_by_title_and_synopsis(params[:query])
      # Preventing SQL Injection and Database error for
      # unknown characters
    else
      @movies = Movie.all.sort_by(&:title)
    end
  end
end
