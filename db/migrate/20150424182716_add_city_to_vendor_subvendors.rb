class AddCityToVendorSubvendors < ActiveRecord::Migration
  def change
    add_column :vendor_subvendors, :city, :integer
  end
end
