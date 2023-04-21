class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true

  before_destroy :update_likes_counter

  private

  def update_likes_counter
    post.update_column(:likes_counter, post.likes_count - 1)
  end
end
