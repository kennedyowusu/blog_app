class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :update_comments_counter

  validates :text, presence: true
  validates :text, length: { minimum: 1, maximum: 500 }
  validates :text, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'only allows letters and numbers' }

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
