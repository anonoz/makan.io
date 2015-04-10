class CreateFoodMenuOptions < ActiveRecord::Migration
  def change
    create_table :food_menu_options do |t|
      t.integer :food_menu_id, index: true
      t.integer :food_option_id, index: true

      t.timestamps null: false
    end

  end
end
