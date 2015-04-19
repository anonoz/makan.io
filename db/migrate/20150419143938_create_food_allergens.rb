class CreateFoodAllergens < ActiveRecord::Migration
  def change
    create_table :food_allergens do |t|
      t.string :title
      t.references :vendor_vendor

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
