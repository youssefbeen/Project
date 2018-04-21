class Article < ApplicationRecord
    validates :title, :description, :price, presence: true
    validates :description, length: {minimum: 30}
    validates :price, numericality: {only_integer: true}
end
