require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Robert', email: 'robert@rob.com', password: '123456', id: 1) }
  let(:post) { Post.new(content: 'My first post', user_id: 1, id: 1) }
  let(:comment) { Comment.new(content: 'This is a comment', user_id: 1, post_id: 1, id: 1) }

  context 'validation' do
    it 'is valid if it has content' do
      user.save
      post.save
      expect(comment).to be_valid
    end

    it 'is not valid if content is empty' do
      comment.content = nil
      expect(comment).to_not be_valid
    end
  end
end
