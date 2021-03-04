class Account::FriendshipsController < ApplicationController
  include FriendshipsHelper
  before_action :find_account
  before_action :find_friendship, only: :create
  before_action :check_accept?

  def create
    if send?
      # Установить I18n и вынести строки
      if @friendship.save
        flash[:success] = 'Friend Request Sent!'
        @notification = new_notification(@account, current_account.id, 'friendRequest')
        @notification.save
      else
        flash[:danger] = 'Friend Request Failed!'
      end
    end

    redirect_back(fallback_location: root_path)
  end

  def accept_friend
    if @friendship.save
      flash[:success] = 'Friend Request Accepted!'
      change_status
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_back(fallback_location: root_path)
  end

  def decline_friend
    if @friendship.destroy
      flash[:success] = 'Friend Request Declined!'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def find_account
    @account = Account.find(params[:account_id])
  end

  def find_friendship
    @friendship = current_account.friend_sent.build(sent_to_id: params[:account_id])
  end

  def send?
    current_account.id == params[:account_id] || friend_request_sent? || friend_request_received?
  end

  def check_accept?
    @friendship = Friendship.find_by(sent_by_id: params[:account_id], sent_to_id: current_account.id, status: false)
    return unless @friendship

    @friendship.status = true
  end

  def change_status
    @friendship.update(status: true)
  end
end
