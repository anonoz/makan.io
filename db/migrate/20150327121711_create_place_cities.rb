class CreatePlaceCities < ActiveRecord::Migration
  def change
    create_table :place_cities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
