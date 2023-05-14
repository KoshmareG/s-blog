class CreatePostLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_likes do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :post, null: false, foreign_key: true, index: true
      t.index [:user_id, :post_id], unique: true

      t.timestamps
    end
  end
end
