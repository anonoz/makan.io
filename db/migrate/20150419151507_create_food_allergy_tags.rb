class CreateFoodAllergyTags < ActiveRecord::Migration
  def change
    create_table :food_allergy_tags do |t|
      t.references :food_menu
      t.references :food_allergen

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
