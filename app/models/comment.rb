class Comment < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :content, presence: true

  belongs_to :post
  belongs_to :user

  def destroy
    update(deleted_at: Time.current)
  end
end