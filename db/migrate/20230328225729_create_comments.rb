class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
