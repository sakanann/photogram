class Picture < ApplicationRecord
  validates :title, presence:true
  validates :image, presence: true
  validates :content, presence: true,
            length: { maximum: 255 }
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
end
