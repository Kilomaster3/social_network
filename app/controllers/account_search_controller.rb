# frozen_string_literal: true

class AccountSearchController < AccountBaseAuthController
  def search
    query = params[:search_accounts].presence && params[:search_accounts][:query]
    @accounts = Account.search_account(query) if query
  end
end
