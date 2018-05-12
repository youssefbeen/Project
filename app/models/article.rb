class Article < ApplicationRecord
    
    has_many :pictures
    accepts_nested_attributes_for :pictures,  reject_if: proc{ |param| param[:picture].blank? && param[:picture_cache].blank? && param[:id].blank? }, allow_destroy: true
    
    belongs_to :user
    belongs_to :category
    belongs_to :city
    attr_accessor :picture, :picture_cache, :remove_picture
    
    accepts_nested_attributes_for :user

    validates :title, :description, :price, presence: true
    validates :description, length: {minimum: 30}
    validates :price, numericality: {only_integer: true}
    #validates_associated :user
end
