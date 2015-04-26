class AddVendorVendorIdToOrderChits < ActiveRecord::Migration
  def change
    add_column :order_chits, :vendor_vendor_id, :integer
  end
end
