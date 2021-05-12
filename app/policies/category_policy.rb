# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    account.admin?
  end
end
