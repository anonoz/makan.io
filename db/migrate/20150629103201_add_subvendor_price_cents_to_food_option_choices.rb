class AddSubvendorPriceCentsToFoodOptionChoices < ActiveRecord::Migration
  def change
    add_column :food_option_choices, :subvendor_price_cents, :integer, default: 0
  end
end
