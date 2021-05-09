# frozen_string_literal: true

module Admin
  class AccountsPolicy < ApplicationPolicy
    def index?
      account.admin?
    end
  end
end
