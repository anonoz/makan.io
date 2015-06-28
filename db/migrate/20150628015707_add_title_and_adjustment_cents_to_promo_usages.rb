class AddTitleAndAdjustmentCentsToPromoUsages < ActiveRecord::Migration
  def change
    add_column :promo_usages, :title, :string
    add_column :promo_usages, :adjustment_cents, :integer
  end
end
