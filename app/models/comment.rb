# frozen_string_literal: true

class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller&.current_account }

  belongs_to :post
  belongs_to :account
  validates :body, presence: true
end
