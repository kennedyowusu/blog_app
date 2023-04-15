class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true
  after_commit :update_post_likes_counter, on: [:create, :destroy]

  private

  def update_post_likes_counter
    post.update_column(:likes_counter, post.likes_count)
  end
end
