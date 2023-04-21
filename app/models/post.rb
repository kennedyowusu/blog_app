class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Use counter_cache to update comments_counter and likes_counter
  # every time a new comment or like is created or destroyed
  has_many :comments, dependent: :destroy, counter_cache: true
  has_many :likes, dependent: :destroy, counter_cache: true

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
