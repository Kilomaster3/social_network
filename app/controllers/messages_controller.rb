# frozen_string_literal: true

class MessagesController < AccountBaseAuthController
  def index
    @message = Message.new
    @messages = Message.order('created_at DESC')
  end

  def create
    message = Message.create!(message_params)

    message.broadcast
  end

  private

    def message_params
      params.require(:message).permit(:body, :chatroom_id, :account_id)
    end
end
