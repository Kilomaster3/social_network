class Notification < ApplicationRecord
  belongs_to :account
  scope :friend_requests, -> { where(notice_type: 'friendRquest') }
  scope :likes, -> { where(notice_type: 'like') }
  scope :comments, -> { where(notice_type: 'comment') }
end
