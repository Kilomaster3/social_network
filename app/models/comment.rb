class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :account
  validates :body, presence: true
  has_paper_trail
end
