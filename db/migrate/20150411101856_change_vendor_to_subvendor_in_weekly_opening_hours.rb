class ChangeVendorToSubvendorInWeeklyOpeningHours < ActiveRecord::Migration
  def change
    rename_column :vendor_weekly_opening_hours,
                  :vendor_vendor_id, :vendor_subvendor_id
  end
end
