# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[show edit]

  def index
    @chatrooms = Chatroom.all
  end

  def show
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_account.chatroom_account.find_by(chatroom_id: @chatroom.id)
  end

  def edit; end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    def chatroom_params
      params.require(:chatroom).permit(:name)
    end
end
