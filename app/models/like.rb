# frozen_string_literal: true

class Like < ApplicationRecord
  include Reaction
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller&.current_account }
end
