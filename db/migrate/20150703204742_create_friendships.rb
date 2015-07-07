class CreateFriendships < ActiveRecord::Migration
  def change
    create_table "friendships", :force => true, :id => false do |t|
    	t.integer "user_id", :null => false
  		t.integer "friend_id", :null => false
    end
    # add_index :user_id
  end
end
