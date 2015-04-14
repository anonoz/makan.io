class AddVendorVendorIdToFoodOptions < ActiveRecord::Migration
  def change
    add_column :food_options, :vendor_vendor_id, :integer
  end
end
