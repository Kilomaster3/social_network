class PublicController < ApplicationController
  def home
    if current_account
      @friends = current_account.friends
      @pending_request = current_account.pending_requests
      @friend_requests = current_account.received_requests
      @accounts = Account.all
    end
  end
end
