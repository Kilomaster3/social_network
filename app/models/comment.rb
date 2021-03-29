class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller&.current_account }

  belongs_to :post
  belongs_to :account
  validates :body, presence: true
end
