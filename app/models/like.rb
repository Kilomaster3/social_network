class Like < ApplicationRecord
  include Reaction
  has_paper_trail
end
