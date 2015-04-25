require 'spec_helper'

describe Order::Item do
  it "is invalid without belong to order chit" do
    chitless_item = build(:order_item, order_chit: nil)
    chitless_item.valid?
    expect(chitless_item.errors[:order_chit]).to(
      include "can't be blank")
  end

  it "is invalid without belong to food menu" do
    foodless_item = build(:order_item, food_menu: nil)
    foodless_item.valid?
    expect(foodless_item.errors[:food_menu]).to(
      include "can't be blank")
  end

  it "is not deleted if quantity is >= 1" do
    exile = create(:order_item)
    exile.update(quantity: 2)
    expect(exile.deleted?).to be_falsy
  end

  it "is deleted if it is saved with quantity <= 0" do
    exile = create(:order_item)
    exile.update(quantity: 0)
    expect(exile.deleted?).to be_truthy
  end
end
