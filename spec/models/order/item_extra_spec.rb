require 'spec_helper'

describe Order::ItemExtra do
  it "is invalid without belonging to order item" do
    itemless_extra = build(:order_item_extra, order_item: nil)
    itemless_extra.valid?
    expect(itemless_extra.errors[:order_item]).to(
      include "can't be blank")
  end

  it "is invalid without belonging to food option choice" do
  	choiceless_extra = build(:order_item_extra, food_option_choice: nil)
  	choiceless_extra.valid?
  	expect(choiceless_extra.errors[:food_option_choice]).to(
  	  include "can't be blank")
  end

  it "is invalid with quantity of less than 0" do
    abomination = build(:order_item_extra, quantity: -1)
    abomination.valid?
    expect(abomination.errors[:quantity]).to(
      include "must be greater than or equal to 0")
  end

  it "has amount of $1 if its chosen with food option choice of $1" do
    choice = create(:food_option_choice, unit_amount: 1)
    extra = build(:order_item_extra, food_option_choice: choice)
    expect(extra.amount).to eq(1)
  end

  it "has amount of $2 if 2 of it are chosen with food option choice of $1" do
    choice = create(:food_option_choice, unit_amount: 1)
    extra = build(:order_item_extra, food_option_choice: choice, quantity: 2)
    expect(extra.amount).to eq(2)
  end
end
