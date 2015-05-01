class AddRemarksToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :remarks, :text
  end
end
