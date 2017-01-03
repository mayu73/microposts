class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
