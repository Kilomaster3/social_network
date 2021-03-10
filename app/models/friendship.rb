class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'Account', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'Account', foreign_key: 'sent_by_id'
  scope :friends, -> { Friendship.where(status: true) }
  scope :not_friends, -> { Friendship.where(status: false) }
end
