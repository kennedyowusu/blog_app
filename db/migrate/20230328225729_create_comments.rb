class CreateComments < ActiveRecord::Migration[7.0]
  def up
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end

    add_index :comments, :user_id unless index_exists?(:comments, :user_id)
    add_index :comments, :post_id unless index_exists?(:comments, :post_id)
  end

  def down
    drop_table :comments
  end
end
