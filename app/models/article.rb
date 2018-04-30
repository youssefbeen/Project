class Article < ApplicationRecord
    
    has_many :pictures, dependent: :destroy
    accepts_nested_attributes_for :pictures, allow_destroy: true
    belongs_to :user
    belongs_to :category
    
    
    validates :title, :description, :price, presence: true
    validates :description, length: {minimum: 30}
    validates :price, numericality: {only_integer: true}
end
