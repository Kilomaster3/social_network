class AccountPolicy < ApplicationPolicy

  def index?
    owner? || account.admin?
  end

  def show?
    owner? || account.admin?
  end

  def new?
    owner? || account.admin?
  end

  def update?
    owner? || account.admin?
  end

  def edit?
    owner? || account.admin?
  end
end
