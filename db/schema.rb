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

ActiveRecord::Schema.define(version: 20150407093615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_addresses", force: :cascade do |t|
    t.integer  "customer_user_id"
    t.integer  "place_area_id"
    t.string   "address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "customer_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "phone"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_users", ["confirmation_token"], name: "index_customer_users_on_confirmation_token", unique: true, using: :btree
  add_index "customer_users", ["email"], name: "index_customer_users_on_email", unique: true, using: :btree
  add_index "customer_users", ["reset_password_token"], name: "index_customer_users_on_reset_password_token", unique: true, using: :btree

  create_table "food_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_menus", force: :cascade do |t|
    t.integer  "vendor_vendor_id"
    t.string   "title"
    t.integer  "base_price",                 default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "food_category_id"
    t.string   "feature_photo_file_name"
    t.string   "feature_photo_content_type"
    t.integer  "feature_photo_file_size"
    t.datetime "feature_photo_updated_at"
  end

  create_table "food_option_choices", force: :cascade do |t|
    t.integer  "food_option_id"
    t.string   "title"
    t.integer  "min",              default: 0
    t.integer  "max",              default: 0
    t.integer  "unit_amount",      default: 0
    t.integer  "default_quantity", default: 0
    t.boolean  "default_chosen"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "food_options", force: :cascade do |t|
    t.integer  "food_menu_id"
    t.string   "title"
    t.integer  "jenis",        default: 1
    t.integer  "min",          default: 0
    t.integer  "max",          default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  create_table "place_areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "place_city_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "place_cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendor_special_closing_hours", force: :cascade do |t|
    t.integer  "vendor_vendor_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "vendor_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
  end

  add_index "vendor_users", ["email"], name: "index_vendor_users_on_email", unique: true, using: :btree
  add_index "vendor_users", ["reset_password_token"], name: "index_vendor_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_vendors", force: :cascade do |t|
    t.string   "title"
    t.text     "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendor_weekly_opening_hours", force: :cascade do |t|
    t.integer  "vendor_vendor_id"
    t.integer  "wday",             default: 1
    t.integer  "start_at",         default: 0
    t.integer  "end_at",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end