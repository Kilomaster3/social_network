# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  def self.search(term)
    where('name ILIKE ?', "%#{term}%")
  end
end
