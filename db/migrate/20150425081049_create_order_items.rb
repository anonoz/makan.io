class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_chit_id
      t.integer :food_menu_id
      t.integer :quantity, default: 1

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
