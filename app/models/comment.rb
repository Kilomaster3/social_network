# frozen_string_literal: true

class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller&.current_account }

  belongs_to :post
  belongs_to :account
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many  :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  validates :body, presence: true
end
