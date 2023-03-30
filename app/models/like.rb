class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  belongs_to :post, counter_cache: true

  validates :user, :post, presence: true
  validates :user_id, uniqueness: { scope: :post_id }
  validates :user_id, exclusion: { in: ->(like) { [like.post.author_id] } }

  after_create :increment_post_likes_counter
  after_destroy :decrement_post_likes_counter

  private

  def increment_post_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_post_likes_counter
    post.decrement!(:likes_counter)
  end
end
