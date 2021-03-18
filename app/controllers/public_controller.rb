class PublicController < ApplicationController
  def home
    if current_account
      @pending_request = current_account.pending_requests
      @friend_requests = current_account.received_requests
      @accounts = Account.where.not(id: current_account.id)
    end
  end
end
