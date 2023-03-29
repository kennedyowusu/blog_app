class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :name, null: false
      t.string :photo
      t.text :bio
      t.integer :post_counter, default: 0, null: false

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
