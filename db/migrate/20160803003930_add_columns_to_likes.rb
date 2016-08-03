class AddColumnsToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :liking_user, :references 
    add_column :likes, :liked_user, :references
  end
end
