# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :masqueradable, :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :dislikes
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :accounts_interests, dependent: :destroy
  has_many :interests, through: :accounts_interests

  # scope :online, ->{ where('last_seen_at > ?', 40.minutes.ago) }

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers 'online'
    where(id: ids)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  enum role: %i[account admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
      account.email = auth.info.email
      account.password = Devise.friendly_token[0, 20]
      account.first_name = auth.info.first_name
      account.last_name = auth.info.last_name
      account.skip_confirmation!
    end
  end


  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.new_with_session(params, session)
    super.tap do |account|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        account.email = data['email'] if account.email.blank?
      end
    end
  end
end
