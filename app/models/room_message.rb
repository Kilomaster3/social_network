class RoomMessage < ApplicationRecord
  belongs_to :account
  belongs_to :room, inverse_of: :room_messages
end
