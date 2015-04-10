class CreateVendorSubvendors < ActiveRecord::Migration
  def change
    create_table :vendor_subvendors do |t|
      t.integer :vendor_id
      t.string :title

      t.timestamps null: false
    end
  end
end
