class RemoveVendorVendorFromFoodCategory < ActiveRecord::Migration
  def change
    remove_column :food_categories, :vendor_vendor_id, :integer
  end
end
