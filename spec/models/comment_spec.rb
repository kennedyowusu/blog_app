require 'rails_helper'

RSpec.describe Comment, type: :model do
  testuser = User.create(name: 'Kenney Owusu', photo: 'user-photo', bio: 'sample bio', posts_counter: 0)
  testpost = Post.create(author: testuser, title: 'post title', text: 'post content', likes_counter: 0, comments_counter: 0)

  subject do
    Comment.new(author: testuser, post: testpost, text: 'post comment')
  end

  it 'should validate the presence of author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should validate the presence of post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should validate the presence of text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'should validate the length of the text' do
    subject.text = 'a' * 501
    expect(subject).to_not be_valid

    subject.text = 'a'
    expect(subject).to be_valid
  end

  it 'should validate the presence of the author and post associations' do
    subject.author = nil
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should validate the presence of the foreign keys' do
    subject.author_id = nil
    subject.post_id = nil
    expect(subject).to_not be_valid
  end
end
