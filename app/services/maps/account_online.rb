# frozen_string_literal: true

module Maps
  class AccountOnline < ApplicationService
    attr_reader :current_account

    def initialize(account)
      @current_account = account
    end

    def call
      @account_online = Account.where('last_seen_at > ?', 1.minute.ago)

      @account_online.map do |account|
        full_name_path = "<a href='#{Rails.application.routes.url_helpers.account_profile_path(account)}'>#{account.full_name}</a>"
        { account_id: account.id,
          full_name_path: full_name_path }
      end
    end
  end
end
