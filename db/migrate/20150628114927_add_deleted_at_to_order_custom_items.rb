class AddDeletedAtToOrderCustomItems < ActiveRecord::Migration
  def change
    add_column :order_custom_items, :deleted_at, :datetime
  end
end
