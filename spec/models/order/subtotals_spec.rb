require 'spec_helper'

describe "Order Chit Subtotal" do
  it "updates when item is added" do
    chit = create(:order_chit)
    chit.items.create(food_menu: create(:food_menu, base_price: 2.00))
    expect(chit.reload.subtotal).to eq 2
  end

  it "updates when item is removed" do
    chit = create(:order_chit)

    item = build(:order_item,
                  food_menu: create(:food_menu, base_price: 2.00))
    chit.items << item
    expect(chit.reload.subtotal).to eq 2

    item2 = create(:order_item,
                   order_chit: chit,
                   food_menu: create(:food_menu, base_price: 3.50))
    expect(chit.reload.subtotal).to eq 5.5

    chit.items.delete item
    expect(chit.reload.subtotal).to eq 3.5

    item2.destroy
    expect(chit.reload.subtotal).to eq 0
  end

  it "updates when item extra is added" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit,
    	          food_menu: create(:food_menu, base_price: 2.00))
    
    extra1 = create(:order_item_extra,
               food_option_choice: create(:food_option_choice,
                 unit_amount: 1.00))
    item.extras << extra1
    expect(chit.reload.subtotal).to eq 3

    extra2 = create(:order_item_extra,
               order_item: item,
               food_option_choice: create(:food_option_choice,
                 unit_amount: 1.5))
    expect(chit.reload.subtotal).to eq 4.5

    extra3 = create(:order_item_extra,
               order_item: item,
               quantity: 2,
               food_option_choice: create(:food_option_choice,
                 unit_amount: 1.8))
    expect(chit.reload.subtotal).to eq 8.1
  end

  it "updates when item extras are removed" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit,
                    food_menu: create(:food_menu, base_price: 2.00))

    extra1 = create(:order_item_extra, order_item:item,
                      food_option_choice: create(:food_option_choice,
                        unit_amount: 1.5))
    extra2 = create(:order_item_extra, order_item:item,
                      quantity: 2,
                      food_option_choice: create(:food_option_choice,
                        unit_amount: 1.9))

    expect(chit.reload.subtotal).to eq 7.3
    
    extra1.destroy
    expect(chit.reload.subtotal).to eq 5.8

    item.extras.delete extra2
    expect(chit.reload.subtotal).to eq 2
  end
end
