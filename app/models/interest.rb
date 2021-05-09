# frozen_string_literal: true

class Interest < ApplicationRecord
  has_many :accounts_interests, dependent: :destroy
  has_many :accounts, through: :accounts_interests
  belongs_to :category
end
