class AddAvailabilityToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :availability, :boolean, default: true
  end
end
