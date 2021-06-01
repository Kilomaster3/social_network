# frozen_string_literal: true

class MessagesController < AccountBaseAuthController
  def index
    @messages = Message.order('created_at DESC')
    @accounts = Account.paginate(page: params[:page], per_page: 4).where.not(id: current_account.id)
  end

  def new
    @message = Message.new
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
