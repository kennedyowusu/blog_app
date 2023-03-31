require 'rails_helper'

RSpec.describe Post, type: :model do
  include Shoulda::Matchers::ActiveModel
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(250) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_least(10) }
    it { is_expected.to validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  testuser = User.create(name: 'Kennedy Owusu', photo: 'user-image', bio: 'user bio', posts_counter: 0)

  subject do
    Post.new(author: testuser, title: 'post title', text: 'post content', likes_counter: 0, comments_counter: 0)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'is not valid with text shorter than 10 characters' do
    subject.text = 'a' * 9
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative comments counter' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative likes counter' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter is a valid positive integer' do
    subject.comments_counter = 0
    expect(subject).to be_valid
  end

  it 'likes counter is a valid positive integer' do
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'is not valid with a non-integer comments counter' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a non-integer likes counter' do
    subject.likes_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'returns recent comments' do
    expect(subject.recent_comments).to eq([])
  end
end
