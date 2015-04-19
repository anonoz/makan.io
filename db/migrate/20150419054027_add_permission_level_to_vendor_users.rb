class AddPermissionLevelToVendorUsers < ActiveRecord::Migration
  def change
    add_column :vendor_users, :permission_level, :integer, default: 1
  end
end
