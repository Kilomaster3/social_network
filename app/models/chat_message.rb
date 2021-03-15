class ChatMessage < ApplicationRecord
  belongs_to :account
  belongs_to :message, inverse_of: :chat_messages
end
