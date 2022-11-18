# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :bookmarks
  #has_one_attached :poster_url
  # validates :title, uniqueness: true
  validates :title, :overview, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
    against: [ :title, :overview],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
