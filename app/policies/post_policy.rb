class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def show?
    belongs_to_account? || account.admin?
  end

  def create?
    belongs_to_account? || account.admin?
  end

  def update?
    belongs_to_account? || account.admin?
  end

  def destroy?
    belongs_to_account? || account.admin?
  end
end
