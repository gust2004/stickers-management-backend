# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_15_164556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "uuid", null: false
    t.integer "number_of_stickers", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_albums_on_uuid"
  end

  create_table "collections", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "album_id", null: false
    t.bigint "collector_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_collections_on_album_id"
    t.index ["collector_id"], name: "index_collections_on_collector_id"
    t.index ["uuid"], name: "index_collections_on_uuid"
  end

  create_table "collectors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_collectors_on_email"
    t.index ["name"], name: "index_collectors_on_name"
    t.index ["uuid"], name: "index_collectors_on_uuid"
  end

  create_table "stickers", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "collection_id", null: false
    t.integer "number", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_stickers_on_collection_id"
    t.index ["uuid"], name: "index_stickers_on_uuid"
  end

  add_foreign_key "collections", "albums"
  add_foreign_key "collections", "collectors"
  add_foreign_key "stickers", "collections"
end
