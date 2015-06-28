class CreatePromoUsages < ActiveRecord::Migration
  def change
    create_table :promo_usages do |t|
      t.references :order_chit, index: true
      t.integer :promo_id
      t.string :promo_type
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :promo_usages, :deleted_at
  end
end
