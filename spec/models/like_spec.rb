require 'rails_helper'

RSpec.describe Like do
  let(:testuser) { User.create(name: 'John Doe', photo: 'userphoto', bio: 'This is John Doe', posts_counter: 0) }
  let(:testpost) { Post.create(author: testuser, title: 'New Post', text: 'New Post Created For Testing', comments_counter: 0, likes_counter: 0) }

  it "should decrease post likes counter by 1" do
    testpost.update(likes_counter: 1)
    subject = Like.new(user_id: testuser.id, post_id: testpost.id)
    subject.save
    expect { subject.destroy }.to change { testpost.reload.likes_counter }.by(-1)
  end

  it "should decrease post likes counter by 1 when a like is destroyed" do
    testpost.update(likes_counter: 1)
    like = Like.create(user_id: testuser.id, post_id: testpost.id)
    expect { like.destroy }.to change { testpost.reload.likes_counter }.by(-1)
  end

  it 'should increase post likes counter by 1' do
    subject = Like.create(user_id: testuser.id, post_id: testpost.id)
    expect { subject.increment_post_likes_counter_public }.to change { testpost.reload.likes_counter }.by(1)
  end

  it "should validate the presence of user_id" do
    post = Post.create(author: testuser, title: 'New Post', text: 'New Post Created For Testing', comments_counter: 0, likes_counter: 0)
    subject = Like.new(post: post)
    expect(subject).to_not be_valid
  end

  it "should validate the presence of user_id and post" do
    subject.user_id = nil
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it "should not allow a user to like their own post" do
    subject.user_id = testpost.author_id
    expect(subject).to_not be_valid
  end

  it "should not allow a user to like the same post more than once" do
    duplicate_like = subject.dup
    expect(duplicate_like).to_not be_valid
  end

end
