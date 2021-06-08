# frozen_string_literal: true

class Chatroom < ApplicationRecord
  has_many :chatroom_accounts, dependent: :destroy
  has_many :accounts, through: :chatroom_accounts
  has_many :messages, dependent: :destroy

  scope :direct_messages, -> { where(direct_message: true) }

  def self.direct_message_for_accounts(accounts)
    account_ids = accounts.map(&:id).sort
    name = "DM:#{account_ids.join(':')}"

    if (chatroom = direct_messages.find_by(name: name))
      chatroom
    else
      # create a new chatroom
      chatroom = new(name: name, direct_message: true)
      chatroom.accounts = accounts
      chatroom.save
      chatroom
    end
  end
end
