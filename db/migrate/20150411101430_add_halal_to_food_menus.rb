class AddHalalToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :halal, :boolean, default: true
  end
end
