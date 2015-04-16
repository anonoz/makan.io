class MonetizingDatabase < ActiveRecord::Migration
  def change
    rename_column :food_menus, :base_price, :base_price_cents
    rename_column :food_option_choices, :unit_amount, :unit_amount_cents
  end
end
