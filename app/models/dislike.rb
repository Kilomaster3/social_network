class Dislike < ApplicationRecord
  include Reaction
  has_paper_trail
end
