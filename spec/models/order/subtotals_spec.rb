require 'spec_helper'

describe "Order Chit Subtotal" do
  it "updates when item is added" do
    chit = create(:order_chit)
    chit.items.create(food_menu: create(:food_menu, base_price: 2.00))
    expect(chit.subtotal).to eq 2
  end

  it "updates when item is removed" do
    chit = create(:order_chit)
    
    item = build(:order_item,
                  food_menu: create(:food_menu, base_price: 2.00))
    chit.items << item
    expect(chit.subtotal).to eq 2

    item2 = create(:order_item,
    	           order_chit: chit,
                   food_menu: create(:food_menu, base_price: 3.50))
    expect(chit.reload.subtotal).to eq 5.5

    chit.items.delete item
    expect(chit.reload.subtotal).to eq 3.5

    item2.destroy
    expect(chit.subtotal).to eq 0
  end

  # it "updates when item extra is added"
end
