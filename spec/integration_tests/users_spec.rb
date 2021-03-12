require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user1) { User.create(name: 'Richard', email: 'rick@user1.com', password: '123456', id: 1) }
  let(:user2) { User.create(name: 'Robert', email: 'robert@user2.com', password: '123456', id: 2) }
  let(:post) { Post.new(content: 'My first post', user_id: 2, id: 1) }

  describe 'sign up process' do
    it 'signs me up' do
      visit '/users/sign_up'
      fill_in 'Name', with: user1.name
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      fill_in 'Password confirmation', with: user1.password
      click_button
      page.has_button?('Sign Out')
    end
  end

  def login(user1)
    visit '/users/sign_in'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button
  end

  context 'views:' do
    it 'displays users list on users/index page' do
      user1.save
      user2.save
      login(user2)
      visit '/users'
      page.should have_content('Richard')
      page.should have_content('Robert')
    end

    it 'displays Add Friend button on users/index page' do
      user1.save
      login(user1)
      visit '/users'
      page.has_button?('Add Friend')
    end
  end

  describe 'see another user main page' do
    it 'displays recent posts from user' do
      user1.save
      user2.save
      login(user2)
      fill_in 'Add New Post', with: post.content
      click_button
      click_link 'Sign out'
      login(user1)
      visit '/users'
      first('.btn-outline-success').click
      page.has_content?('Recent posts:')
    end
  end
end
