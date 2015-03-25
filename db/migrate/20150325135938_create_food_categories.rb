class CreateFoodCategories < ActiveRecord::Migration
  def change
    create_table :food_categories do |t|
      t.integer :vendor_id
      t.string :title

      t.timestamps null: false
    end
  end
end
