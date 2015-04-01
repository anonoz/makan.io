class CreateVendorWeeklyOpeningHours < ActiveRecord::Migration
  def change
    create_table :vendor_weekly_opening_hours do |t|
      t.integer :vendor_vendor_id
      t.integer :wday, default: 1
      t.integer :start_at, default: 0000
      t.integer :end_at, default: 0000

      t.timestamps null: false
    end
  end
end
