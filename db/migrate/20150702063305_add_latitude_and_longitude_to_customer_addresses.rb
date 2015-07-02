class AddLatitudeAndLongitudeToCustomerAddresses < ActiveRecord::Migration
  def change
    add_column :customer_addresses, :latitude, :float
    add_column :customer_addresses, :longitude, :float
  end
end
