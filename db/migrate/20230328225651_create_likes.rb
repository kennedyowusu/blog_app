class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, null: false, { to_table: :users }
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:author_id, :post_id]
  end

  def down
    drop_table :likes
  end
end
