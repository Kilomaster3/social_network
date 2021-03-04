class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable


  has_one_attached :avatar
  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :dislikes
  mount_uploader :avatar, AvatarUploader
end
