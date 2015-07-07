class AddCityToVendorVendors < ActiveRecord::Migration
  def change
    add_column :vendor_vendors, :city, :string
    add_index :vendor_vendors, :city
  end
end
