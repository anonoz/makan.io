class SetDefaultCityValuesToSubvendorsAndAreas < ActiveRecord::Migration
  def up
    Place::Area.update_all city: 1
    Vendor::Subvendor.update_all city: 1
  end

  def down
  end
end
