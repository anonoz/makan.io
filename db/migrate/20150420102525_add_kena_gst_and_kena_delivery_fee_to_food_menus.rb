class AddKenaGstAndKenaDeliveryFeeToFoodMenus < ActiveRecord::Migration
  def change
    add_column :food_menus, :kena_gst, :boolean, default: false
    add_column :food_menus, :kena_delivery_fee, :boolean, default: false
  end
end
