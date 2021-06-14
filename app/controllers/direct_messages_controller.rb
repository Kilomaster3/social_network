# frozen_string_literal: true

class DirectMessagesController < AccountBaseAuthController
  def show
    accounts = [current_account, Account.find(params[:id])]
    @chatroom = Chatroom.direct_message_for_accounts(accounts)
    @messages = @chatroom.messages.includes(:account).order(created_at: :desc).limit(100).reverse
    @chatroom_account = current_account.chatroom_accounts.find_by(chatroom_id: @chatroom.id)
    render 'chatrooms/show'
  end
end
