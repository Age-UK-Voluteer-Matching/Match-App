class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :userinterests
  has_many :interests, through: :userinterests, dependent: :destroy
  has_many :older_relationships, class_name: 'Match', foreign_key: "older_id", dependent: :destroy
  has_many :older_users , through: :older_relationships, source: :volunteer_user

  mount_uploader :image, ImageUploader
end
