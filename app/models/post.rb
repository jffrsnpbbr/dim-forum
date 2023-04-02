class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true

  def destroy
    print(:destroy)
    update(deleted_at: Time.now)
  end
end
