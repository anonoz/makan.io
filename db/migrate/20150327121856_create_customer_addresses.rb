class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.integer :customer_user_id
      t.integer :place_area_id
      t.string :address

      t.timestamps null: false
    end
  end
end
