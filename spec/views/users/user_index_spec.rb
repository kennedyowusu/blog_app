require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @photo = 'https://picsum.photos/300/200'
    @user = User.create(name: 'Kennedy', photo: @photo, bio: 'Software Engineer', posts_counter: 12)
    visit users_path
  end

  it 'Show user name' do
    expect(page).to have_content(@user.name)
  end

  it 'I can see the profile picture for each user.' do
    expect(page).to have_css('img')
  end

  it 'Should see the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'should  redirect to user show page when clicked' do
    click_link(@user.name)
    visit user_path(@user)
    expect(current_path).to eql(user_path(@user))
  end
end
