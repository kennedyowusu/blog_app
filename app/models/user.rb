class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates :photo, presence: true
  attribute :posts_counter, :integer, default: 0
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def create_post(params)
    post = posts.create(params)
    post.save # save the post to the database
    post # return the post object
  end
end
