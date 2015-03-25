class CreateFoodMenus < ActiveRecord::Migration
  def change
    create_table :food_menus do |t|
      t.integer :vendor_id
      t.string :title
      t.integer :base_price

      t.timestamps null: false
    end
  end
end
