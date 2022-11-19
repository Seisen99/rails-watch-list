# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'lists#index'
  resources :lists, only: %i[index show new create destroy search_movie] do
    resources :bookmarks, only: %i[new create]
  end
  resources :bookmarks, only: [:destroy]
  resources :movies, only: %i[index show search_movie]
end
