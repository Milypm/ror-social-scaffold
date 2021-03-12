require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:user1) { User.create(name: 'Richard', email: 'rick@user1.com', password: '123456', id: 1) }
  let(:user2) { User.create(name: 'Robert', email: 'robert@user2.com', password: '123456', id: 2) }
  let(:user3) { User.create(name: 'Helen', email: 'helen@user3.com', password: '123456', id: 3) }
  let(:friendship) { Friendship.create(user_id: 1, friend_id: 2, confirmed: true, id: 1) }
  let(:post1) { Post.create(id: 1, user_id: 2, content: 'Roberts First post') }
  let(:post2) { Post.create(id: 2, user_id: 1, content: 'Richards First post') }
  let(:post3) { Post.create(id: 3, user_id: 3, content: 'Helens First post') }
  let(:like) { Like.create(id: 1, post_id: 1, user_id: 1) }

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

  context 'User signs in' do
    it 'shows the timeline-posts page as root page' do
      login(user2)
      expect(page).to have_button('Save')
      page.should have_content('Recent posts')
    end
  end

  context 'User goes to timeline-posts page' do
    it 'shows the posts created by himself and his friends' do
      login(user1)
      page.has_content?('RICHARDS FIRST POST')
      page.has_content?('ROBERTS FIRST POST')
    end

    it 'does not show the posts created by a user who is not a friend' do
      login(user1)
      page.should_not have_content('HELENS FIRST POST')
    end
  end

  context 'User clicks Like on a post from another user' do
    it 'shows the number of likes for a post' do
      login(user1)
      page.has_content?('1 Likes')
    end
  end
end
