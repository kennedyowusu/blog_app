class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments

  validates :title, presence: true
  validates :text, presence: true, length: { minimum: 10 }

  def increment_comments_counter
    self.increment!(:comments_counter)
  end

  def increment_likes_counter
    self.increment!(:likes_counter)
  end

  def decrement_likes_counter
    self.decrement!(:likes_counter)
  end

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
