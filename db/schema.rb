ActiveRecord::Schema[7.0].define(version: 2023_03_30_202949) do

  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "post_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["author_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title", null: false
    t.text "text", null: false
    t.integer "comments_counter", default: 0, null: false
    t.integer "likes_counter", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "photo"
    t.text "bio"
    t.integer "posts_counter", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users", column: "author_id"
  add_foreign_key "posts", "users", column: "author_id"
end
