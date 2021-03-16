class RoomsController < ApplicationController
  before_action :load_entities

  def index
    @chats = Room.all
  end

  def new
    @chat = Room.new
  end

  def create
    @chat = Room.new(permitted_parameters)

    if @chat.save
      flash[:success] = "Chat #{@chat.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @chat_message = RoomMessage.new room: @chat
    @chat_messages = @chat.room_messages.includes(:account)
  end

  private

  def load_entities
    @chats = Room.all
    @chat = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
