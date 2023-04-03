class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true

  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  
  def destroy
    print(:destroy)
    update(deleted_at: Time.now)
  end
end
