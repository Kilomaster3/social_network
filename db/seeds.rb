# frozen_string_literal: true

# Generate accounts
10.times do
  account = Account.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456',
    password_confirmation: '123456',
    confirmed_at: Time.now.utc,
    latitude: rand(53.8924818..53.9025719),
    longitude: rand(27.5474400..27.5782749)
  )

  # Generate posts
  5.times do
    Post.create(
      title: Faker::DcComics.hero,
      content: Faker::DcComics.title,
      account_id: account.id
    )
  end
end

# Generate admin account
Account.create(
  first_name: 'Admin',
  last_name: 'Admin',
  email: 'admin@admin.admin',
  password: '12345678',
  password_confirmation: '12345678',
  confirmed_at: Time.now.utc,
  latitude: rand(53.8924818..53.9025719),
  longitude: rand(27.5782749..27.5474400),
  role: :admin
)

accounts = Account.all

# Generate Followers
accounts.each_with_index do |account, index|
  3.times do |time|
    followed = accounts[index + time + 1]

    next unless followed

    Relationship.create!(
      follower_id: account.id,
      followed_id: followed.id
    )
  end
end

# Generate Category
5.times do
  category = Category.create!(
    name: Faker::Vehicle.manufacture
  )
  5.times do
    Interest.create!(
      name: Faker::Vehicle.make,
      category_id: category.id
    )
  end
end

# Generate Likes && Dislikes
accounts.each do |account|
  foreign_posts = Post.where.not(account_id: account.id)

  liked_posts = foreign_posts.sample(10)

  # Create Like
  liked_posts.each do |post|
    Like.create!(
      post_id: post.id,
      account_id: account.id
    )
  end

  disliked_posts = (foreign_posts - liked_posts).sample(5)

  # Create Dislike
  disliked_posts.each do |post|
    Dislike.create!(
      post_id: post.id,
      account_id: account.id
    )
  end

  # Generate Tags
  5.times do
    Tag.create!(
      name: Faker::ProgrammingLanguage.name
    )
  end
end
