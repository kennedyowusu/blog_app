class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.references :post, foreign_key: true, null: false
      t.timestamps null: false
    end
    add_index :likes, [:author_id, :post_id], unique: true
  end
end
