# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140215235447) do

  create_table "foods", force: true do |t|
    t.integer  "user_id",                null: false
    t.string   "name",                   null: false
    t.integer  "ref_count",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["user_id"], name: "index_foods_on_user_id"

  create_table "servings", force: true do |t|
    t.integer  "user_id"
    t.integer  "day_order"
    t.float    "quantity"
    t.string   "name"
    t.integer  "calories"
    t.date     "when_eaten"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], name: "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], name: "index_user_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "email",                               null: false
    t.string   "crypted_password",                    null: false
    t.string   "password_salt",                       null: false
    t.string   "persistence_token",                   null: false
    t.string   "single_access_token",                 null: false
    t.string   "perishable_token",                    null: false
    t.integer  "login_count",         default: 0,     null: false
    t.integer  "failed_login_count",  default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "daily_calorie_goal",  default: 2000,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
