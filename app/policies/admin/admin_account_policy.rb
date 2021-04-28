class AdminAccountsPolicy < ApplicationPolicy
  def index?
    account.admin?
  end
end
