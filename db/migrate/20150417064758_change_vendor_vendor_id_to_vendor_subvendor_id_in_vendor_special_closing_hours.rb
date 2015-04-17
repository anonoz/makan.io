class ChangeVendorVendorIdToVendorSubvendorIdInVendorSpecialClosingHours < ActiveRecord::Migration
  def change
    rename_column :vendor_special_closing_hours,
                  :vendor_vendor_id, :vendor_subvendor_id
  end
end
