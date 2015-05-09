class AddSubtotalToOrderChits < ActiveRecord::Migration
  def change
    add_column :order_chits, :subtotal_cents, :integer, default: 0
  end
end
