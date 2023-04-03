class Category < ApplicationRecord
  has_many :post_category_ships
  has_many :posts, through: :post_category_ships
  
  validates :name, presence: true
end