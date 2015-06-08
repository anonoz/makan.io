class AddSlugToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :slug, :string
    add_index :food_menus, :slug, unique: true
  end
end
