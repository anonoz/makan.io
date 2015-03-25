class CreateVendorVendors < ActiveRecord::Migration
  def change
    create_table :vendor_vendors do |t|
      t.string :title
      t.text :address
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
