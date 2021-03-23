class PublicController < ApplicationController
  def home
    if current_account
      @accounts = Account.where.not(id: current_account.id)
    end
  end
end
