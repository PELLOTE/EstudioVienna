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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130522171406) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "extension"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "assistants", :force => true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "surname"
    t.string   "instrument"
    t.string   "nickname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "booking_id"
  end

  create_table "booking_times", :force => true do |t|
    t.integer  "booking_id"
    t.integer  "hora_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "booking_tools", :force => true do |t|
    t.integer  "booking_id"
    t.integer  "tool_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bookings", :force => true do |t|
    t.date     "fecha"
    t.integer  "amount"
    t.string   "estate"
    t.integer  "room_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "payment"
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "equipment", :force => true do |t|
    t.string   "tool"
    t.string   "trademark"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "horas", :force => true do |t|
    t.string   "name"
    t.integer  "endTime"
    t.integer  "startTime"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.integer  "group_id"
    t.string   "name"
    t.string   "lastname"
    t.string   "surname"
    t.string   "instrument"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "music_styles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.integer  "price"
    t.integer  "max"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "style_groups", :force => true do |t|
    t.integer  "group_id"
    t.integer  "music_style_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tools", :force => true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.string   "trademark"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "price_unitary"
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "name"
    t.string   "lastname"
    t.string   "surname"
    t.string   "instrument"
    t.integer  "fono"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "user_type_id"
    t.boolean  "active"
    t.boolean  "block"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
