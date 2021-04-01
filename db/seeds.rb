# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#10.times do
# Account.create(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   email: Faker::Internet.email,
#   password: '123456789',
#   password_confirmation: '123456789',
#   confirmed_at: Time.now.utc
# )
#end

Tag.create(name: 'Recipe')
Tag.create(name: 'Travel')
Tag.create(name: 'News')
Tag.create(name: 'Humour')


Interest.create(name: 'Bnw')
Interest.create(name: 'Mers')
Interest.create(name: 'Subary')
Interest.create(name: 'Mazda')
