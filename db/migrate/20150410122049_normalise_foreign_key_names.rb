class NormaliseForeignKeyNames < ActiveRecord::Migration
  def change
    rename_column :food_menus, :subvendor_id, :vendor_subvendor_id
    rename_column :vendor_subvendors, :vendor_id, :vendor_vendor_id
    rename_column :vendor_users, :vendor_id, :vendor_vendor_id
  end
end
