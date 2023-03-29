class CreateLikes < ActiveRecord::Migration[7.0]
  def up
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps null: false
    end

    unless index_exists?(:likes, :user_id)
      add_index :likes, :user_id
    end

    unless index_exists?(:likes, :post_id)
      add_index :likes, :post_id
    end
  end

  def down
    drop_table :likes
  end
end

