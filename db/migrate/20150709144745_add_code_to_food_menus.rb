class AddCodeToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :code, :string
    add_index :food_menus, :code
  end
end
