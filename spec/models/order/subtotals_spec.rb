require 'spec_helper'

describe "Order Chit Subtotal" do
  it "calculates properly with item of multiple quantity" do
    chit = create(:order_chit,
                  items: [
                    build(:order_item,
                      orderable: create(:food_menu, base_price: 2.9),
                      quantity: 2
                    )
                  ])
    expect(chit.subtotal).to eq 5.8
  end

  it "updates when item is added" do
    chit = create(:order_chit)
    chit.items.create(orderable: create(:food_menu, base_price: 2.00))
    expect(chit.reload.subtotal).to eq 2
  end

  it "updates when item associated to chit is created" do
    chit = create(:order_chit)
    item = create(:order_item,
                  order_chit_id: chit.id,
                  orderable: create(:food_menu, base_price: 2.00))

    expect(chit.reload.subtotal).to eq 2
  end

  it "updates when item is removed from collection" do
    chit = create(:order_chit)

    item = build(:order_item,
                  orderable: create(:food_menu, base_price: 2.00))
    chit.items << item
    expect(chit.reload.subtotal).to eq 2

    item2 = create(:order_item,
                   order_chit: chit,
                   orderable: create(:food_menu, base_price: 3.50))
    expect(chit.reload.subtotal).to eq 5.5

    chit.items.delete item
    expect(chit.reload.subtotal).to eq 3.5
  end

  it "updates when item is destroyed" do
    chit = create(:order_chit)
    item2 = create(:order_item,
                   order_chit: chit,
                   orderable: create(:food_menu, base_price: 3.50))
    expect(chit.reload.subtotal).to eq 3.5

    item2.destroy
    expect(chit.reload.subtotal).to eq 0
  end

  it "updates when item's order chit is changed to nil" do
    chit = create(:order_chit)
    item = create(:order_item,
                  order_chit: chit,
                  orderable: create(:food_menu, base_price: 2.8))

    expect(chit.reload.subtotal).to eq 2.8

    item.update(order_chit: nil)

    expect(chit.reload.subtotal).to eq 0
  end

  it "updates when item's order chit ID is changed to nil" do
    chit = create(:order_chit)
    item = create(:order_item,
                  order_chit_id: chit.id,
                  orderable: create(:food_menu, base_price: 2.8))

    expect(chit.reload.subtotal).to eq 2.8

    item.update(order_chit_id: nil)

    expect(chit.reload.subtotal).to eq 0
  end

  it "updates on both chits when item's chit id change to another chit" do
    chit1 = create(:order_chit)
    chit2 = create(:order_chit)

    item = create(:order_item,
                  order_chit: chit1,
                  orderable: create(:food_menu, base_price: 13.37))

    expect(chit1.reload.subtotal).to eq 13.37
    expect(chit2.reload.subtotal).to eq 0

    item.update(order_chit_id: chit2.id)

    expect(chit1.reload.subtotal).to eq 0
    expect(chit2.reload.subtotal).to eq 13.37
  end

  it "updates when extra is added to collection" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit,
                orderable: create(:food_menu, base_price: 2.00))
    
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

  it "updates when extra associated to item is created" do
    chit = create(:order_chit)
    item = create(:order_item,
                  order_chit: chit,
                  orderable: create(:food_menu, base_price: 2.00))

    extra2 = create(:order_item_extra,
                    order_item: item,
                    food_option_choice: create(:food_option_choice,
                    unit_amount: 1.5))
    expect(chit.reload.subtotal).to eq 3.5
  end

  it "updates both chits when extras' item id changes to other item on other chit" do
    chit1 = create(:order_chit)
    chit2 = create(:order_chit)

    item1 = create(:order_item,
                   order_chit: chit1,
                   orderable: create(:food_menu, base_price: 2.00))
    item2 = create(:order_item,
                   order_chit: chit2,
                   orderable: create(:food_menu, base_price: 3.00))

    extra = create(:order_item_extra,
                   order_item: item1,
                   food_option_choice: create(:food_option_choice,
                   unit_amount: 1.5))

    expect(chit1.reload.subtotal).to eq 3.5
    expect(chit2.reload.subtotal).to eq 3

    extra.update(order_item_id: item2.id)

    expect(chit1.reload.subtotal).to eq 2
    expect(chit2.reload.subtotal).to eq 4.5
  end

  it "updates when extras are removed from collection" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit,
                    orderable: create(:food_menu, base_price: 2.00))

    extra2 = create(:order_item_extra, order_item:item,
                      quantity: 2,
                      food_option_choice: create(:food_option_choice,
                        unit_amount: 1.9))

    expect(chit.reload.subtotal).to eq 5.8

    item.extras.delete extra2
    expect(chit.reload.subtotal).to eq 2
  end

  it "updates when extra is destroyed" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit,
                    orderable: create(:food_menu, base_price: 2.00))

    extra1 = create(:order_item_extra, order_item:item,
                      food_option_choice: create(:food_option_choice,
                        unit_amount: 1.5))

    expect(chit.reload.subtotal).to eq 3.5

    extra1.destroy
    expect(chit.reload.subtotal).to eq 2
  end
end
