# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :masqueradable, :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy,
                                   inverse_of: :followed

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :accounts_interests, dependent: :destroy
  has_many :interests, through: :accounts_interests

  has_many :chatroom_accounts, dependent: :destroy
  has_many :chatrooms, through: :chatroom_accounts

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  searchkick

  scope :last_seen, -> { where('last_seen_at > ?', 7.days.ago) }

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers 'online'
    where(id: ids)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  enum role: { account: 0, admin: 1 }

  # rubocop:disable Rails/FindBy
  def self.from_omniauth(access_token)
    data = access_token.info
    account = Account.where(email: data['email']).first

    unless account
      account ||= Account.create(email: data['email'],
                                 password: Devise.friendly_token[0, 20])
      account.skip_confirmation!
      account.save!
    end
    account
  end
  # rubocop:enable Rails/FindBy

  def admin?
    role == 'admin'
  end

  def account?
    role == 'accounts'
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

  def friends
    friends_ids = following.pluck(:id) & followers.pluck(:id)
    Account.where(id: friends_ids)
  end

  def followers_without_friend
    ids = followers.pluck(:id) - following.pluck(:id)
    Account.where(id: ids)
  end

  def self.search_account(query)
    __elasticsearch__.search({
                               query: {
                                 multi_match: {
                                   query: query,
                                   fields: %w[first_name last_name]
                                 }
                               }
                             })
  end
end
