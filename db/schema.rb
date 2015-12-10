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

ActiveRecord::Schema.define(version: 20151115123648) do

  create_table "ads", force: :cascade do |t|
    t.string   "ad_content"
    t.string   "ad_image"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ads", ["created_at"], name: "index_ads_on_created_at"
  add_index "ads", ["member_id"], name: "index_ads_on_member_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "member_id"
    t.integer  "ad_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["ad_id"], name: "index_comments_on_ad_id"
  add_index "comments", ["member_id"], name: "index_comments_on_member_id"

  create_table "members", force: :cascade do |t|
    t.string   "login"
    t.string   "full_name"
    t.date     "birthday"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "role",            default: 1
    t.string   "provider"
    t.string   "uid"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["login"], name: "index_members_on_login", unique: true

end
