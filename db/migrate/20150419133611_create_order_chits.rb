class CreateOrderChits < ActiveRecord::Migration
  def change
    create_table :order_chits do |t|
      # Who
      t.integer :customer_user_id
      t.string :offline_customer_name

      # Where
      t.integer :customer_address_id
      t.string :offline_customer_address
      t.string :offline_customer_phone

      # What
      t.string :status # draft, ordered, rejected, accepted, delivered
      t.text :remarks

      t.timestamps null: false
      t.datetime :deleted_at
    end
  end
end
