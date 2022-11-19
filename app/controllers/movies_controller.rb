# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :search_movie, only: %i[index show]

  def new
    @movie = Movie.new
  end

  def index
    # if params[:query].present?
    #   @query = params[:query]
    #   @movies = Movie.search_by_title_and_synopsis(params[:query])
    #   # Preventing SQL Injection and Database error for
    #   # unknown characters
    # else
    #   @movies = Movie.all.sort_by(&:title)
    # end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private

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
