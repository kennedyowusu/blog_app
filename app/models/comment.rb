class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :update_comments_counter

  validates :text, presence: true

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
