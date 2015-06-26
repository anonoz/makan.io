class MakeOrderItemPolymorphic < ActiveRecord::Migration
  def up
    rename_column :order_items, :food_menu_id, :orderable_id
    add_column :order_items, :orderable_type, :string, default: "Food::Menu"
    add_index :order_items, :orderable_id

    # For existing orderable items, they should just be Food::Menu
    execute "update order_items set orderable_type = 'Food::Menu';"
  end

  def down
    remove_index :order_items, :orderable_id
  	rename_column :order_items, :orderable_id, :food_menu_id
    remove_column :order_items, :orderable_type, :string
  end
end
