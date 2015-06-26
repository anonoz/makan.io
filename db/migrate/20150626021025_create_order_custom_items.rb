class CreateOrderCustomItems < ActiveRecord::Migration
  def change
    create_table :order_custom_items do |t|
      t.string :title
      t.integer :base_price_cents
      t.integer :vendor_subvendor_id
      t.boolean :kena_gst
      t.boolean :kena_delivery_fee
      t.integer :subvendor_price_cents

      t.timestamps null: false
    end
  end
end
