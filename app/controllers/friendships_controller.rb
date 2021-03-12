class FriendshipsController < ApplicationController
  include ApplicationHelper

  before_action :set_friendship, only: %i[show destroy]

  def index
    @friendships = Friendship.all
    @friends = current_user.friends
  end

  def show; end

  def new
    @friendship = Friendship.new
  end

  def edit; end

  def create
    if current_user.friends.include?(who_sent_invite)
      redirect_back fallback_location: @users, notice: 'You already have a friendship with this user!'
    else
      @friendship = current_user.friendships.build(friend_id: params[:friend_id], confirmed: false)
      if @friendship.save
        redirect_back fallback_location: @users, notice: 'Friend request sent succesfully.'
      else
        redirect_back fallback_location: @users, notice: 'Unable to add friend.'
      end
    end
  end

  def accept_friendship
    if who_received_invite.confirm_friend(who_sent_invite)
      Friendship.create!(friend_id: who_sent_invite.id, user_id: who_received_invite.id, confirmed: true)
      redirect_to friendships_path(@user), notice: 'Friend Request Accepted!'
    else
      redirect_to friendships_path(@user), notice: 'Unable to accept friend request'
    end
  end

  def destroy
    if who_received_invite.decline_friendship(who_sent_invite)
      redirect_to friendships_path(@user), notice: 'Friend Request Not Accepted.'
    else
      redirect_to friendships_path(@user), notice: 'Error: Unable to decline friend request.'
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    { user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false }
  end

  def who_sent_invite
    User.find(friendship_params[:user_id])
  end

  def who_received_invite
    User.find(friendship_params[:friend_id])
  end
end
