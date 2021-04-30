module Admin
  class AccountsPolicy < ApplicationPolicy
    def index?
      account.admin?
    end
  end
end
