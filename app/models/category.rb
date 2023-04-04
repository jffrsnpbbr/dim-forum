class Category < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :name, presence: true
  
  has_many :post_category_ships
  has_many :posts, through: :post_category_ships

  def destroy
    update(deleted_at: Time.current)
  end
end