class CreatePosts < ActiveRecord::Migration[7.0]
  def up
    create_table :posts do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :text, null: false
      t.integer :comments_counter, default: 0, null: false
      t.integer :likes_counter, default: 0, null: false

      t.timestamps
    end

    unless index_exists?(:posts, :author_id)
      add_index :posts, :author_id
    end
  end

  def down
    drop_table :posts
  end
end
