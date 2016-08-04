class RenameColumnInFollows < ActiveRecord::Migration
  def change
  	rename_column :follows, :following_user, :following_user_id
    rename_column :follows, :followed_user, :followed_user_id
  end
end
