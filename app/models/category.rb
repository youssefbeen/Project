class Category < ApplicationRecord
    
    has_many :articles
    mount_uploader :image, ImageUploader
    
end
