require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Kennedy Owusu', photo: 'userphoto', bio: 'Learning to code', posts_counter: 0) }

  before do
    subject.photo = 'userphoto'
    subject.save
  end

  it 'should return the recent posts' do
    Post.create(author: subject, title: 'Testing Title', text: 'Testing Description', comments_counter: 0,
                likes_counter: 0)
    posts = subject.recent_posts
    expect(posts.length).to eq(1)
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'requires a user bio' do
    user = User.new(name: 'Kennedy Owusu', photo: 'userphoto', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'requires a user name' do
    user = User.new(photo: 'userphoto', bio: 'Learning to code', posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'requires a user photo' do
    user = User.new(name: 'Kennedy Owusu', bio: 'Learning to code', posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'should return the recent posts' do
    Post.create(author: subject, title: 'Testing Title', text: 'Testing Description', comments_counter: 0,
                likes_counter: 0)
    posts = subject.recent_posts
    expect(posts.length).to eq(1)
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should be able to create a post' do
    post = subject.posts.create(title: 'Testing Title', text: 'Testing Description', comments_counter: 0,
                                likes_counter: 0)
    expect(post).to be_valid
  end

  it 'should return the correct number of posts' do
    5.times do
      subject.posts.create(title: 'Testing Title', text: 'Testing Description', comments_counter: 0, likes_counter: 0)
    end
    expect(subject.posts.count).to eq(5)
  end
end
