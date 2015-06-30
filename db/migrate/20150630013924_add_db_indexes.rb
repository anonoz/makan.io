class AddDbIndexes < ActiveRecord::Migration
  def change
    add_index :customer_addresses, :customer_user_id
    add_index :customer_addresses, :place_area_id
    add_index :food_allergens, :vendor_vendor_id
    add_index :food_allergy_tags, :food_menu_id
    add_index :food_allergy_tags, :food_allergen_id
    add_index :food_categories, :vendor_vendor_id
    add_index :food_menus, :food_category_id
    add_index :food_menus, :vendor_subvendor_id
    add_index :food_option_choices, :food_option_id
    add_index :food_options, :vendor_vendor_id
    add_index :order_chits, :customer_user_id
    add_index :order_chits, :customer_address_id
    add_index :order_chits, :vendor_vendor_id
    add_index :order_custom_items, :vendor_subvendor_id
    add_index :order_item_extras, :order_item_id
    add_index :order_item_extras, :food_option_choice_id
    add_index :order_items, :order_chit_id
    add_index :order_items, [:orderable_id, :orderable_type]
    add_index :promo_usages, [:promo_id, :promo_type]
    add_index :vendor_special_closing_hours, :vendor_subvendor_id
    add_index :vendor_subvendors, :vendor_vendor_id
    add_index :vendor_users, :vendor_vendor_id
    add_index :vendor_weekly_opening_hours, :vendor_subvendor_id
  end
end
