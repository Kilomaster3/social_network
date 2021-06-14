# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    follower_id { follower.id }
    followed_id { followed.id }
  end
end
