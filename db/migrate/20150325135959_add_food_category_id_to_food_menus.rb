class AddFoodCategoryIdToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :food_category_id, :integer
  end
end
