class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 50
      t.string :photo, default: "https://picsum.photos/300/200"
      t.text :bio
      t.integer :posts_counter, default: 0
      t.index :name
      t.timestamps
    end
  end
end
