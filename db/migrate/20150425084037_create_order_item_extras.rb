class CreateOrderItemExtras < ActiveRecord::Migration
  def change
    create_table :order_item_extras do |t|
      t.integer :order_item_id
      t.integer :food_option_choice_id
      t.integer :quantity, default: 1

      t.timestamps null: false
    end
  end
end
