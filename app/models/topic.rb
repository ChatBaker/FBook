class Topic < ActiveRecord::Base
  validates :content,    length: { maximum: 60 }
  
  mount_uploader :image, ImageUploader
  belongs_to:user
  has_many :comments, dependent: :destroy
end
