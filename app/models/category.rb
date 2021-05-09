# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :interests, dependent: :delete_all
end
