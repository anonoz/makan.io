class CreateFoodOptions < ActiveRecord::Migration
  def change
    create_table :food_options do |t|
      t.integer :food_menu_id
      t.string :title
      t.integer :type
      t.integer :min
      t.integer :max

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
