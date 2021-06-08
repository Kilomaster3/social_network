# frozen_string_literal: true

module Maps
  class AccountCurrentLocation < ApplicationService
    attr_reader :current_account

    def initialize(account)
      @current_account = account
    end

    def call
      @current_account = Account.where(id: current_account.id)

      @current_account.map do |account|
        full_name_path = "<a href='#{Rails.application.routes.url_helpers.accounts_profile_path(account)}'>#{account.full_name}</a>"
        { account_id: account.id,
          full_name_path: full_name_path }
      end
    end
  end
end
