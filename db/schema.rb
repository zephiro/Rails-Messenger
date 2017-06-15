# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170615052252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "message_threads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "u_ids", array: true
    t.index ["u_ids"], name: "index_message_threads_on_u_ids", using: :gin
  end

  create_table "message_threads_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_thread_id"], name: "index_message_threads_users_on_message_thread_id"
    t.index ["user_id"], name: "index_message_threads_users_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "message_thread_id"
    t.bigint "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_thread_id"], name: "index_messages_on_message_thread_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "message_threads_users", "message_threads"
  add_foreign_key "message_threads_users", "users"
  add_foreign_key "messages", "message_threads"
  add_foreign_key "messages", "users"
end
