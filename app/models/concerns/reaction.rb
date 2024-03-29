# frozen_string_literal: true

module Reaction
  extend ActiveSupport::Concern

  included do
    belongs_to :post
    belongs_to :account
  end
end
