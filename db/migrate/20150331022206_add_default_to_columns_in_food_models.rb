class AddDefaultToColumnsInFoodModels < ActiveRecord::Migration
  def change
    change_column_default :food_menus, :base_price, 0
    change_column_default :food_options, :jenis, 1
    change_column_default :food_options, :min, 0
    change_column_default :food_options, :max, 0
    change_column_default :food_option_choices, :min, 0
    change_column_default :food_option_choices, :max, 0
    change_column_default :food_option_choices, :unit_amount, 0
    change_column_default :food_option_choices, :default_quantity, 0
  end
end
