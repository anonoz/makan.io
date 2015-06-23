class AddSubvendorPriceCentsToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :subvendor_price_cents, :integer, default: 0
  end
end
