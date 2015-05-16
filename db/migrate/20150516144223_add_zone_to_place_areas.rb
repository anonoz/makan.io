class AddZoneToPlaceAreas < ActiveRecord::Migration
  def change
    add_column :place_areas, :zone, :integer
  end
end
