require 'spec_helper'

describe Order::ItemExtra do
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

  it "allows update if chit is not delivered/finished" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit)
    extra = create(:order_item_extra, order_item: item)
    expect(extra.update(quantity: 2)).to be_truthy
    
    chit.reject!
    expect(extra.update(quantity: 3)).to be_truthy
  end

  it "disallows update if chit is delivered/finished" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit)
    extra = create(:order_item_extra, order_item: item)

    chit.accept!
    chit.deliver!
    expect(extra.update(quantity: 2)).to be_falsy

    chit.finish!
    expect(extra.update(quantity: 3)).to be_falsy
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

  it "won't change amount even if the choice's amount has changed", versioning: true do
    Timecop.travel Time.parse "January 1"
    choice = create(:food_option_choice, unit_amount: 1)

    Timecop.travel Time.parse "January 7"
    extra = create(:order_item_extra, food_option_choice: choice, quantity: 1)

    Timecop.travel Time.parse "January 14"
    choice.update(unit_amount: 2)
    expect(extra.amount).to eq 1

    Timecop.return
  end
end
