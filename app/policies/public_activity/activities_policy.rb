# frozen_string_literal: true

module PublicActivity
  class ActivitiesPolicy < ApplicationPolicy
    def index?
      true
    end
  end
end
