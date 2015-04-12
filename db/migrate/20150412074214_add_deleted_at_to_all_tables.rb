class AddDeletedAtToAllTables < ActiveRecord::Migration
  def change
    add_column :customer_addresses, :deleted_at, :datetime
    add_column :customer_users, :deleted_at, :datetime
    add_column :food_categories, :deleted_at, :datetime
    add_column :food_menu_options, :deleted_at, :datetime
    add_column :food_menus, :deleted_at, :datetime
    add_column :food_option_choices, :deleted_at, :datetime
    # add_column :food_options, :deleted_at, :datetime
    add_column :place_areas, :deleted_at, :datetime
    add_column :place_cities, :deleted_at, :datetime
    add_column :vendor_special_closing_hours, :deleted_at, :datetime
    add_column :vendor_subvendors, :deleted_at, :datetime
    add_column :vendor_users, :deleted_at, :datetime
    add_column :vendor_vendors, :deleted_at, :datetime
    add_column :vendor_weekly_opening_hours, :deleted_at, :datetime
  end
end
