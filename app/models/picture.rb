class Picture < ApplicationRecord
    belongs_to :article
    mount_uploader :picture, ImageUploader
#    attr_accessor :picture, :picture_cache, :remove_picture



   

end
