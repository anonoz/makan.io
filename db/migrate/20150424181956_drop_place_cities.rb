class DropPlaceCities < ActiveRecord::Migration
  def change
    drop_table :place_cities
  end
end
