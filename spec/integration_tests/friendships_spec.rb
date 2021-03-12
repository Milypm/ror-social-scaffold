require 'rails_helper'

RSpec.describe 'Friendship', type: :feature do
  let(:user1) { User.create(name: 'Richard', email: 'rick@user1.com', password: '123456', id: 1) }
  let(:user2) { User.create(name: 'Robert', email: 'robert@user2.com', password: '123456', id: 2) }
  let(:friendship) { Friendship.new(user_id: 1, friend_id: 2, confirmed: true, id: 1) }

  def login(user1)
    visit '/users/sign_in'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button
  end

  def login(user2)
    visit '/users/sign_in'
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button
  end

  context 'click on Add Friend button' do
    it 'shows the name of the friendship requestor on the friendship receiver show page' do
      login(user2)
      visit '/users'
      first('.mb-2').click
      click_link 'Sign out'
      login(user1)
      visit user_path(user1)
      page.should have_content('Richard')
    end
  end
end
