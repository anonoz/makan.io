class CreateFoodOptionChoices < ActiveRecord::Migration
  def change
    create_table :food_option_choices do |t|
      t.integer :food_option_id
      t.string :title
      t.integer :min
      t.integer :max
      t.integer :unit_amount
      t.integer :default_quantity
      t.boolean :default_chosen

      t.timestamps null: false
    end
  end
end
