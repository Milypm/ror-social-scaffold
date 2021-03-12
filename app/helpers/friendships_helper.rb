module FriendshipsHelper
  def show_friendship_btn
    if Friendship.find_by(user_id: current_user.id, friend_id: @user.id)
      nil
    elsif Friendship.find_by(user_id: @user.id, friend_id: current_user.id)
      nil
    else
      return if current_user.id == @user.id

      link_to 'Add Friend', friendships_path(user_id: current_user.id,
                                             friend_id: @user.id), method: :post, class: 'btn btn-success pt-2'
    end
  end

  def index_friendship_btn(user)
    if Friendship.find_by(user_id: current_user.id, friend_id: user.id)
      nil
    elsif Friendship.find_by(user_id: user.id, friend_id: current_user.id)
      nil
    else
      return if current_user.id == user.id

      link_to 'Add Friend', friendships_path(user_id: current_user.id,
                                             friend_id: user.id), method: :post, class: 'mb-2 btn-sm btn btn-success'
    end
  end

  def show_friend_requests
    return unless current_user == @user

    render 'users/show_friend_requests'
  end
end
