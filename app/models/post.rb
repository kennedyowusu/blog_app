class Post < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :comments, foreign_key: :post_id, class_name: 'Comment'
  has_many :likes, foreign_key: :post_id, class_name: 'Like'
  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private :update_post_counter
end
