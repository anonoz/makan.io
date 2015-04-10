class AddSubvendorIdToFoodMenu < ActiveRecord::Migration
  def change
    add_column :food_menus, :subvendor_id, :integer
    remove_column :food_menus, :vendor_vendor_id, :integer
  end
end
