class RenameVendorIdToVendorVendorIdInFoodCategories < ActiveRecord::Migration
  def change
    rename_column :food_categories, :vendor_id, :vendor_vendor_id
  end
end
