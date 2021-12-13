# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_12_175910) do

  create_table "banner_items", force: :cascade do |t|
    t.integer "banner_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["banner_id"], name: "index_banner_items_on_banner_id"
    t.index ["item_id"], name: "index_banner_items_on_item_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string "bannername"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "img_url"
    t.string "content"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "item_id", null: false
    t.string "status"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_inventories_on_item_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "itemname"
    t.string "rarity"
    t.string "img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "banner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["banner_id"], name: "index_likes_on_banner_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "dateTime"
    t.integer "seller_id", null: false
    t.integer "buyer_id", null: false
    t.integer "item_id", null: false
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_transactions_on_buyer_id"
    t.index ["item_id"], name: "index_transactions_on_item_id"
    t.index ["seller_id"], name: "index_transactions_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.float "credit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "banner_items", "banners"
  add_foreign_key "banner_items", "items"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "users"
  add_foreign_key "likes", "banners"
  add_foreign_key "likes", "users"
  add_foreign_key "transactions", "items"
  add_foreign_key "transactions", "users", column: "buyer_id"
  add_foreign_key "transactions", "users", column: "seller_id"
end
