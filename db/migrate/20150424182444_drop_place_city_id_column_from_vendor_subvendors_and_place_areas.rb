class DropPlaceCityIdColumnFromVendorSubvendorsAndPlaceAreas < ActiveRecord::Migration
  def change
    remove_column :vendor_subvendors, :place_city_id, :integer
    remove_column :place_areas, :place_city_id, :integer
  end
end
