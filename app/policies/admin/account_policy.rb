# frozen_string_literal: true

class Admin::AccountPolicy < ApplicationPolicy
  def index?
    account.admin?
  end
end
