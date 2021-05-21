# frozen_string_literal: true

class ChatroomAccount < ApplicationRecord
  belongs_to :chatroom
  belongs_to :account
end
