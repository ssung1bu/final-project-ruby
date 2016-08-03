class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :following_user
      t.integer :followed_user

      t.timestamps null: false
    end
  end
end
