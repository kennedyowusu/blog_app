class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_author_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def comments_counter
    comments.size
  end

  def likes_counter
    likes.size
  end

  def add_comment(comment)
    comments << comment
    update(comments_counter: comments_counter + 1)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_author_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
