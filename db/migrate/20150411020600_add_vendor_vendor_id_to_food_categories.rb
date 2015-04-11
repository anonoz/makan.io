class AddVendorVendorIdToFoodCategories < ActiveRecord::Migration
  def change
    add_column :food_categories, :vendor_vendor_id, :integer
  end
end
