class RenameVendorIdToVendorVendorIdInFoodMenus < ActiveRecord::Migration
  def change
    rename_column :food_menus, :vendor_id, :vendor_vendor_id
  end
end
