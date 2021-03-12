require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Robert', email: 'robert@rob.com', password: '123456') }

  context 'validation' do
    it 'is valid if there is a name' do
      expect(subject).to be_valid
    end

    it 'is not valid if the name is longer than 20 characters' do
      subject.name = 'Ana Lucia Rodriguez Martinez'
      expect(subject).to_not be_valid
    end
  end

  context 'association' do
    it 'has many posts' do
      have_many(:posts)
    end

    it 'has many comments' do
      have_many(:comments)
    end

    it 'has many likes' do
      have_many(:likes)
    end

    it 'has many friendships' do
      have_many(:friendships)
    end

    it 'has many inverse_friendships' do
      have_many(:inverse_friendships)
    end
  end
end
