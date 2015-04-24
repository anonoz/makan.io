class AddCityToPlaceAreas < ActiveRecord::Migration
  def change
    add_column :place_areas, :city, :integer, default: 1
  end
end
