require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Robert', email: 'robert@rob.com', password: '123456', id: 1) }
  let(:post) { Post.new(content: 'My first post', user_id: 1, id: 1) }

  context 'validation' do
    it 'is valid if it has content' do
      user.save
      expect(post).to be_valid
    end

    it 'is not valid if content is empty' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end

  context 'association' do
    it 'has many comments' do
      have_many(:comments)
    end

    it 'has many likes' do
      have_many(:likes)
    end
  end
end
