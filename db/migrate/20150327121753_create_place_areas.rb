class CreatePlaceAreas < ActiveRecord::Migration
  def change
    create_table :place_areas do |t|
      t.string :name
      t.integer :place_city_id

      t.timestamps null: false
    end
  end
end
