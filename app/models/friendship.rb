class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'Account', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'Account', foreign_key: 'sent_by_id'
  scope :friends, -> { where(status: true) }
  scope :not_friends, -> { where(status: false) }
  validates :sent_by_id, uniqueness: { scope: :sent_to_id, message: 'can only send one time' }
end
