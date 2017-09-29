class Topic < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
