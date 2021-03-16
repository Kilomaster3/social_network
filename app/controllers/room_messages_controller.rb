class RoomMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_entities

  def create
    @chart_message = RoomMessage.create(account: current_account,
                                        room: @chat,
                                        message: params.dig(:room_message, :message))
  end

  private

  def load_entities
    @chat = Room.find params.dig(:room_message, :room_id)
  end
end
