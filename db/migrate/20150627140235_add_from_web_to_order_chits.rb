class AddFromWebToOrderChits < ActiveRecord::Migration
  def up
    add_column :order_chits, :from_web, :boolean, default: true
    execute "update order_chits set from_web = false;"
  end

  def down
    remove_column :order_chits, :from_web
  end
end
