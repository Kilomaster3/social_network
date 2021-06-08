# frozen_string_literal: true

module Admin
  class AccountPolicy < ApplicationPolicy
    def index?
      account.admin?
    end
  end
end
