class AddVendorIdToVendorUsers < ActiveRecord::Migration
  def change
    add_column :vendor_users, :vendor_id, :integer
  end
end
