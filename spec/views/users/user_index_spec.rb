require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @user1 = User.create(name: 'Kennedy Owusu', photo: 'https://picsum.photos/seed/picsum/200/300', bio: 'Learning To Code',
                         posts_counter: 12)
    visit users_path
  end

  it 'Show user name' do
    expect(page).to have_content(@user1.name)
  end

  it 'I can see the profile picture for each user.' do
    expect(page).to have_css('img')
  end

  it 'Should see the number of posts the user has written' do
    expect(page).to have_content(@user1.posts_counter)
  end

  it 'should  redirect to user show page when clicked' do
    click_link(@user1.name)
    visit user_path(@user1)
    expect(current_path).to eql(user_path(@user1))
  end
end
