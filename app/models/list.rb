# frozen_string_literal: true

class List < ApplicationRecord
  has_many :bookmarks
  has_many :movies, through: :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
                  against: %i[title overview],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
