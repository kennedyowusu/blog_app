class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy, class_name: 'Comment'
  has_many :likes, foreign_key: 'post_id', dependent: :destroy, class_name: 'Like'

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { minimum: 10 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increment_comments_counter
    increment!(:comments_counter)
  end

  def increment_likes_counter
    increment!(:likes_counter)
  end

  def decrement_likes_counter
    decrement!(:likes_counter)
  end

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
