# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :dislikes
  has_many :notifications, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  has_many :friend_sent, class_name: 'Friendship',
                         foreign_key: 'sent_by_id',
                         inverse_of: 'sent_by',
                         dependent: :destroy

  has_many :friend_request, class_name: 'Friendship',
                            foreign_key: 'sent_to_id',
                            inverse_of: 'sent_to',
                            dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) },
           through: :friend_sent, source: :sent_to

  has_many :pending_requests, -> { merge(Friendship.not_friends) },
           through: :friend_sent, source: :sent_to

  has_many :received_requests, -> { merge(Friendship.not_friends) },
           through: :friend_request, source: :sent_by

  def full_name
    "#{first_name} #{last_name}"
  end

  def friends_and_own_posts
    myfriends = friends
    our_posts = []
    myfriends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end
    posts.each do |p|
      our_posts << p
    end
    our_posts
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
      account.email = auth.info.email
      account.password = Devise.friendly_token[0, 20]
      account.first_name = auth.info.first_name
      account.last_name = auth.info.last_name
      account.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |account|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        account.email = data['email'] if account.email.blank?
      end
    end
  end
end
