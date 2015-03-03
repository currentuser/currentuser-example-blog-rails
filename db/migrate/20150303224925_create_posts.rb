class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.uuid :user_id
      t.text :body

      t.timestamps null: false
    end
    add_index :posts, :user_id
  end
end
