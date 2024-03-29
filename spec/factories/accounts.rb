# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.zone.now }
    connection { rand(1..100) }
    max_connection { rand(1..100) }
  end
end
