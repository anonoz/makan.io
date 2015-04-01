class CreateVendorSpecialClosingHours < ActiveRecord::Migration
  def change
    create_table :vendor_special_closing_hours do |t|
      t.integer :vendor_vendor_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
