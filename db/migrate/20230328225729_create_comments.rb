class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.references :post, foreign_key: true, null: false
      t.text :text, null: false
      t.timestamps
    end
    add_index :comments, [:author_id, :post_id]
  end
end
