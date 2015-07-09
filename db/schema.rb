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

ActiveRecord::Schema.define(version: 20150709144745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_addresses", force: :cascade do |t|
    t.integer  "customer_user_id"
    t.integer  "place_area_id"
    t.string   "address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "deleted_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "customer_addresses", ["customer_user_id"], name: "index_customer_addresses_on_customer_user_id", using: :btree
  add_index "customer_addresses", ["place_area_id"], name: "index_customer_addresses_on_place_area_id", using: :btree

  create_table "customer_users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
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
    t.datetime "deleted_at"
    t.boolean  "student",                default: false
  end

  add_index "customer_users", ["confirmation_token"], name: "index_customer_users_on_confirmation_token", unique: true, using: :btree
  add_index "customer_users", ["email"], name: "index_customer_users_on_email", unique: true, using: :btree
  add_index "customer_users", ["reset_password_token"], name: "index_customer_users_on_reset_password_token", unique: true, using: :btree

  create_table "food_allergens", force: :cascade do |t|
    t.string   "title"
    t.integer  "vendor_vendor_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "deleted_at"
  end

  add_index "food_allergens", ["vendor_vendor_id"], name: "index_food_allergens_on_vendor_vendor_id", using: :btree

  create_table "food_allergy_tags", force: :cascade do |t|
    t.integer  "food_menu_id"
    t.integer  "food_allergen_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "deleted_at"
  end

  add_index "food_allergy_tags", ["food_allergen_id"], name: "index_food_allergy_tags_on_food_allergen_id", using: :btree
  add_index "food_allergy_tags", ["food_menu_id"], name: "index_food_allergy_tags_on_food_menu_id", using: :btree

  create_table "food_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "vendor_vendor_id"
    t.datetime "deleted_at"
  end

  add_index "food_categories", ["vendor_vendor_id"], name: "index_food_categories_on_vendor_vendor_id", using: :btree

  create_table "food_menu_options", force: :cascade do |t|
    t.integer  "food_menu_id"
    t.integer  "food_option_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "deleted_at"
  end

  add_index "food_menu_options", ["food_menu_id"], name: "index_food_menu_options_on_food_menu_id", using: :btree
  add_index "food_menu_options", ["food_option_id"], name: "index_food_menu_options_on_food_option_id", using: :btree

  create_table "food_menus", force: :cascade do |t|
    t.string   "title"
    t.integer  "base_price_cents",           default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "food_category_id"
    t.string   "feature_photo_file_name"
    t.string   "feature_photo_content_type"
    t.integer  "feature_photo_file_size"
    t.datetime "feature_photo_updated_at"
    t.integer  "vendor_subvendor_id"
    t.boolean  "halal",                      default: true
    t.datetime "deleted_at"
    t.boolean  "kena_gst",                   default: false
    t.boolean  "kena_delivery_fee",          default: false
    t.boolean  "availability",               default: true
    t.string   "slug"
    t.integer  "subvendor_price_cents",      default: 0
    t.string   "code"
  end

  add_index "food_menus", ["code"], name: "index_food_menus_on_code", using: :btree
  add_index "food_menus", ["food_category_id"], name: "index_food_menus_on_food_category_id", using: :btree
  add_index "food_menus", ["slug"], name: "index_food_menus_on_slug", unique: true, using: :btree
  add_index "food_menus", ["vendor_subvendor_id"], name: "index_food_menus_on_vendor_subvendor_id", using: :btree

  create_table "food_option_choices", force: :cascade do |t|
    t.integer  "food_option_id"
    t.string   "title"
    t.integer  "min",                   default: 0
    t.integer  "max",                   default: 0
    t.integer  "unit_amount_cents",     default: 0
    t.integer  "default_quantity",      default: 0
    t.boolean  "default_chosen"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "deleted_at"
    t.integer  "subvendor_price_cents", default: 0
  end

  add_index "food_option_choices", ["food_option_id"], name: "index_food_option_choices_on_food_option_id", using: :btree

  create_table "food_options", force: :cascade do |t|
    t.string   "title"
    t.integer  "kind",             default: 1
    t.integer  "min",              default: 0
    t.integer  "max",              default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.integer  "vendor_vendor_id"
  end

  add_index "food_options", ["vendor_vendor_id"], name: "index_food_options_on_vendor_vendor_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "order_chits", force: :cascade do |t|
    t.integer  "customer_user_id"
    t.string   "offline_customer_name"
    t.integer  "customer_address_id"
    t.string   "offline_customer_address"
    t.string   "offline_customer_phone"
    t.string   "status"
    t.text     "remarks"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "deleted_at"
    t.integer  "vendor_vendor_id"
    t.integer  "subtotal_cents",           default: 0
    t.boolean  "from_web",                 default: true
    t.boolean  "caller_is_student",        default: false
    t.datetime "state_updated_at"
  end

  add_index "order_chits", ["customer_address_id"], name: "index_order_chits_on_customer_address_id", using: :btree
  add_index "order_chits", ["customer_user_id"], name: "index_order_chits_on_customer_user_id", using: :btree
  add_index "order_chits", ["state_updated_at"], name: "index_order_chits_on_state_updated_at", using: :btree
  add_index "order_chits", ["vendor_vendor_id"], name: "index_order_chits_on_vendor_vendor_id", using: :btree

  create_table "order_custom_items", force: :cascade do |t|
    t.string   "title"
    t.integer  "base_price_cents"
    t.integer  "vendor_subvendor_id"
    t.boolean  "kena_gst"
    t.boolean  "kena_delivery_fee"
    t.integer  "subvendor_price_cents"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "deleted_at"
  end

  add_index "order_custom_items", ["vendor_subvendor_id"], name: "index_order_custom_items_on_vendor_subvendor_id", using: :btree

  create_table "order_item_extras", force: :cascade do |t|
    t.integer  "order_item_id"
    t.integer  "food_option_choice_id"
    t.integer  "quantity",              default: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "order_item_extras", ["food_option_choice_id"], name: "index_order_item_extras_on_food_option_choice_id", using: :btree
  add_index "order_item_extras", ["order_item_id"], name: "index_order_item_extras_on_order_item_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_chit_id"
    t.integer  "orderable_id"
    t.integer  "quantity",       default: 1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "deleted_at"
    t.text     "remarks"
    t.string   "orderable_type", default: "Food::Menu"
  end

  add_index "order_items", ["order_chit_id"], name: "index_order_items_on_order_chit_id", using: :btree
  add_index "order_items", ["orderable_id", "orderable_type"], name: "index_order_items_on_orderable_id_and_orderable_type", using: :btree
  add_index "order_items", ["orderable_id"], name: "index_order_items_on_orderable_id", using: :btree

  create_table "place_areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
    t.integer  "city",       default: 1
    t.integer  "zone"
  end

  create_table "promo_usages", force: :cascade do |t|
    t.integer  "order_chit_id"
    t.integer  "promo_id"
    t.string   "promo_type"
    t.datetime "deleted_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
    t.integer  "adjustment_cents"
  end

  add_index "promo_usages", ["deleted_at"], name: "index_promo_usages_on_deleted_at", using: :btree
  add_index "promo_usages", ["order_chit_id"], name: "index_promo_usages_on_order_chit_id", using: :btree
  add_index "promo_usages", ["promo_id", "promo_type"], name: "index_promo_usages_on_promo_id_and_promo_type", using: :btree

  create_table "vendor_special_closing_hours", force: :cascade do |t|
    t.integer  "vendor_subvendor_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "deleted_at"
  end

  add_index "vendor_special_closing_hours", ["vendor_subvendor_id"], name: "index_vendor_special_closing_hours_on_vendor_subvendor_id", using: :btree

  create_table "vendor_subvendors", force: :cascade do |t|
    t.integer  "vendor_vendor_id"
    t.string   "title"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "deleted_at"
    t.integer  "city"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "vendor_subvendors", ["reset_password_token"], name: "index_vendor_subvendors_on_reset_password_token", unique: true, using: :btree
  add_index "vendor_subvendors", ["vendor_vendor_id"], name: "index_vendor_subvendors_on_vendor_vendor_id", using: :btree

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
    t.integer  "vendor_vendor_id"
    t.datetime "deleted_at"
    t.integer  "permission_level",       default: 1
  end

  add_index "vendor_users", ["email"], name: "index_vendor_users_on_email", unique: true, using: :btree
  add_index "vendor_users", ["reset_password_token"], name: "index_vendor_users_on_reset_password_token", unique: true, using: :btree
  add_index "vendor_users", ["vendor_vendor_id"], name: "index_vendor_users_on_vendor_vendor_id", using: :btree

  create_table "vendor_vendors", force: :cascade do |t|
    t.string   "title"
    t.text     "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string   "city"
  end

  add_index "vendor_vendors", ["city"], name: "index_vendor_vendors_on_city", using: :btree

  create_table "vendor_weekly_opening_hours", force: :cascade do |t|
    t.integer  "vendor_subvendor_id"
    t.integer  "wday",                default: 1
    t.integer  "start_at",            default: 0
    t.integer  "end_at",              default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "deleted_at"
  end

  add_index "vendor_weekly_opening_hours", ["vendor_subvendor_id"], name: "index_vendor_weekly_opening_hours_on_vendor_subvendor_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
