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

ActiveRecord::Schema[7.1].define(version: 2025_03_07_074138) do
  create_table "access_logs", force: :cascade do |t|
    t.integer "url_id", null: false
    t.datetime "accessed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_id"], name: "index_access_logs_on_url_id"
  end

  create_table "urls", force: :cascade do |t|
    t.text "original_url"
    t.string "short_url"
    t.datetime "expires_at"
    t.integer "access_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_url"], name: "index_urls_on_short_url"
  end

  add_foreign_key "access_logs", "urls"
end
