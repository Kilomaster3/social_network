class Category < ApplicationRecord
  has_many :interests, dependent: :delete_all
end
