class Message < ApplicationRecord
  has_many :chat_messages, dependent: :destroy, inverse_of: :message
end
