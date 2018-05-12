class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    
    has_many :articles
    before_save { self.email = email.downcase }

    has_secure_password
    
    validates :username, :email, presence: true, length: {minimum:3, maximum: 30}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, format:{with: VALID_EMAIL_REGEX}
    validates :password, confirmation: {case_sensitive: true}
    
end
