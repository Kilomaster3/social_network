class AccountBaseAuthController < ApplicationController
  before_action :authenticate_account!
  before_action :set_last_seen_at, if: :account_signed_in?

  def set_last_seen_at
    current_account.touch(:last_seen_at)
  end
end
