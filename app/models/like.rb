class Like < ApplicationRecord
  include Reaction
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller&.current_account }
end
