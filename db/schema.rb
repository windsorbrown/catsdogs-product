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

ActiveRecord::Schema.define(version: 20160423012258) do

  create_table "daily_votes", force: :cascade do |t|
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_votes", ["photo_id"], name: "index_daily_votes_on_photo_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "photo_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "animal_type"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote_type",  default: 0, null: false
  end

  add_index "votes", ["photo_id"], name: "index_votes_on_photo_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
