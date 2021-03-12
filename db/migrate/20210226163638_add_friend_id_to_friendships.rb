class AddFriendIdToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :friend_id, :integer
  end
end
