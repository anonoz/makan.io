class RemoveFoodMenuIdFromFoodOptions < ActiveRecord::Migration
  def change
    remove_column :food_options, :food_menu_id, :integer
  end
end
