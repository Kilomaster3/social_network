# frozen_string_literal: true

module AccountInterests
  extend ActiveSupport::Concern

  def online
    @account_online = Account.where('last_seen_at > ?', 1.minute.ago)

    data = @account_online.map do |account|
      full_name_path = "<a href='#{account_profile_path(account)}'>#{account.full_name}</a>"
      { account_id: account.id,
        full_name_path: full_name_path }
    end
    render json: data
  end

  def max_connection
    @accounts = Account.where.not(id: current_account.id)

    data = @accounts.map do |account|
      interests = (account.interests & current_account.interests).count.to_f / (account.interests |
        current_account.interests).count * 100
      full_name_path = "<a href='#{account_profile_path(account)}'>#{account.full_name}</a>"
      { account_id: account.id,
        full_name_path: full_name_path,
        interests: interests }
    end
    render json: data.select { |d| d[:interests] >= 60 }
  end

  def current_location
    @current_account = Account.where(id: current_account.id)

    data = @current_account.map do |account|
      full_name_path = "<a href='#{account_profile_path(account)}'>#{account.full_name}</a>"
      { account_id: account.id,
        full_name_path: full_name_path }
    end
    render json: data
  end
end
