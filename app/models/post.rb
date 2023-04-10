class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  validates :post_id, presence: true

  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  has_many :comments

  belongs_to :user

  def destroy
    print(:destroy)
    update(deleted_at: Time.now)
  end
end
