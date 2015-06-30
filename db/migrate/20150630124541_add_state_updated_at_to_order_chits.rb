class AddStateUpdatedAtToOrderChits < ActiveRecord::Migration
  def change
    add_column :order_chits, :state_updated_at, :datetime
    add_index :order_chits, :state_updated_at
  end
end
