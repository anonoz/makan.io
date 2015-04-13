class AddPlaceCityIdToVendorSubvendors < ActiveRecord::Migration
  def change
    add_column :vendor_subvendors, :place_city_id, :integer
  end
end
