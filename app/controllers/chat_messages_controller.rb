class ChatMessagesController < ApplicationController
  before_action :load_entities

  def index
    @chats = ChatMessage.all
  end

  def new
    @chat = ChatMessage.new
  end

  def create
    @message = Message.create(permitted_parameters)
    @chat = ChatMessage.new(account: current_account, message: @message)

    if @chat.save
      flash[:success] = "Chat #{@chat.message.name} was created successfully"
      redirect_to chat_messages_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @chat.update_attributes(permitted_parameters)
      flash[:success] = "Chat #{@chat.message.name} was updated successfully"
      redirect_to chat_messages_path
    else
      render :new
    end
  end

  private

  def load_entities
    @chats = ChatMessage.all
    @chat = ChatMessage.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:chat_message).permit(:name)
  end
end
