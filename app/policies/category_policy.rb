# frozen_string_literal: true

module Admin
  class CategoryPolicy < ApplicationPolicy
    def index?
      account.admin?
    end
  end
end
