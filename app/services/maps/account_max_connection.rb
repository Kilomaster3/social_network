# frozen_string_literal: true

module Maps
  class AccountMaxConnection < ApplicationService
    attr_reader :current_account

    def initialize(account)
      @current_account = account
    end

    def call
      @accounts = Account.where.not(id: current_account.id).where('max_connection >= ?', current_account.max_connection)

      @accounts.map do |account|
        interests = (account.interests & current_account.interests).count.to_f / (account.interests |
          current_account.interests).count * 100
        full_name_path = "<a href='#{Rails.application.routes.url_helpers.account_profile_path(account)}'>#{account.full_name}</a>"
        { account_id: account.id,
          full_name_path: full_name_path,
          interests: interests }
      end
    end
  end
end
