require 'rails_helper'
include Shoulda::Matchers::ActiveModel

RSpec.describe Post, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(250) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_least(10) }
    it { is_expected.to validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { is_expected.to have_many(:comments).with_foreign_key('post_id').dependent(:destroy) }
    it { is_expected.to have_many(:likes).with_foreign_key('post_id').dependent(:destroy) }
  end

  context 'instance methods' do
    describe '#increment_comments_counter' do
      it 'should increment comments_counter by 1' do
        post = build(:post)
        expect { post.increment_comments_counter }.to change { post.comments_counter }.by(1)
      end
    end

    describe '#increment_likes_counter' do
      it 'should increment likes_counter by 1' do
        post = build(:post)
        expect { post.increment_likes_counter }.to change { post.likes_counter }.by(1)
      end
    end

    describe '#decrement_likes_counter' do
      it 'should decrement likes_counter by 1' do
        post = build(:post, likes_counter: 5)
        expect { post.decrement_likes_counter }.to change { post.likes_counter }.by(-1)
      end
    end

    describe '#increment_posts_counter' do
      it 'should increment author posts_counter by 1' do
        user = build(:user)
        post = build(:post, author: user)
        expect { post.increment_posts_counter }.to change { user.reload.posts_counter }.by(1)
      end
    end

    describe '#recent_comments' do
      it 'should return the limit number of recent comments of the post' do
        post = build(:post)
        comments = create_list(:comment, 10, post: post)
        recent_comments = post.recent_comments(5)
        expect(recent_comments).to eq(comments.last(5))
      end
    end
  end
end
