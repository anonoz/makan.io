require 'spec_helper'

describe Order::Item do
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

  it "allows update if chit is not delivered/finished" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit)
    expect(item.update(quantity: 2)).to be_truthy
    
    chit.reject!
    expect(item.update(quantity: 3)).to be_truthy
  end

  it "disallows update if chit is delivered/finished" do
    chit = create(:order_chit)
    item = create(:order_item, order_chit: chit)

    chit.accept!
    chit.deliver!
    expect(item.update(quantity: 2)).to be_falsy

    chit.finish!
    expect(item.update(quantity: 3)).to be_falsy
  end

  it "costs $3 if Nasi Lemak is $3 without extras and other charges" do
    nasi_lemak = create(:food_menu, base_price: 3)
    nasi_lemak_line = build(:order_item, food_menu: nasi_lemak)
    expect(nasi_lemak_line.amount).to eq(3)
  end

  it "costs $3.30 if Nasi Lemak is $3 with delivery fee and no extras" do
    nasi_lemak = create(:food_menu, base_price: 3, kena_delivery_fee: true)
    nasi_lemak_line = build(:order_item, food_menu: nasi_lemak)
    expect(nasi_lemak_line.amount).to eq(3.3)
  end

  it "costs $3.18 if Nasi Lemak is $3 with GST and no extras" do
    nasi_lemak = create(:food_menu, base_price: 3, kena_gst: true)
    nasi_lemak_line = build(:order_item, food_menu: nasi_lemak)
    expect(nasi_lemak_line.amount).to eq(3.18)
  end

  it "costs $3.48 if Nasi Lemak is $3 with both delivery + GST" do
    nasi_lemak = create(:food_menu, base_price: 3,
                        kena_delivery_fee: true, kena_gst: true)
    nasi_lemak_line = build(:order_item, food_menu: nasi_lemak)
    expect(nasi_lemak_line.amount).to eq(3.48)
  end

  it "costs $6.50 if Nasi Lemak has Ayam Rendang of $3.50 without fees and taxes" do
    ayam_rendang = create(:food_option_choice, unit_amount: 3.50)
    nasi_lemak_ar = create(:food_menu, base_price: 3.00)
    nasi_lemak_line = create(:order_item, food_menu: nasi_lemak_ar)
    ayam_rendang_extra = create(:order_item_extra, food_option_choice: ayam_rendang,
                                order_item: nasi_lemak_line)

    expect(nasi_lemak_line.amount).to eq(6.50)
  end

  it "costs $7.54 if Nasi Lemak has Ayam Rendang and kena delivery + GST" do
    ayam_rendang = create(:food_option_choice, unit_amount: 3.50)
    nasi_lemak_ar = create(:food_menu, base_price: 3.00, kena_gst: true, kena_delivery_fee: true)
    nasi_lemak_line = create(:order_item, food_menu: nasi_lemak_ar)
    ayam_rendang_extra = create(:order_item_extra, food_option_choice: ayam_rendang,
                                order_item: nasi_lemak_line)

    expect(nasi_lemak_line.amount).to eq(7.54)
  end

  it "won't change the amount on older chit if base price changes later", versioning: true do
    Timecop.travel Time.parse "November 10"
    food_menu = create(:food_menu, base_price: 6.50)

    Timecop.travel Time.parse "November 25"
    order_chit = create(:order_chit)
    order_item = create(:order_item, food_menu: food_menu, order_chit: order_chit)

    Timecop.travel Time.parse "December 25"
    food_menu.update(base_price: 10.00)
    old_order_item = order_item.reload
    expect(old_order_item.amount).to eq 6.50

    Timecop.return
  end

  it "won't change the amount on older chit if GST kicks in later", versioning: true do
    Timecop.travel Time.parse "April 1"
    food_menu = create(:food_menu, base_price: 1)
    order_chit = create(:order_chit)
    order_item = create(:order_item, food_menu: food_menu, order_chit: order_chit)

    Timecop.travel Time.parse "May 1"
    food_menu.update(kena_gst: true)

    expect(order_item.amount).to eq 1
  end

  it "won't change the amount on older chit if delivery fee kicks in later", versioning: true do
    Timecop.travel Time.parse "April 1"
    food_menu = create(:food_menu, base_price: 1)
    order_chit = create(:order_chit)
    order_item = create(:order_item, food_menu: food_menu, order_chit: order_chit)

    Timecop.travel Time.parse "May 1"
    food_menu.update(kena_delivery_fee: true)

    expect(order_item.amount).to eq 1
  end

  it "won't change the amount on older chit if both fees and price hike kick in later", versioning: true do
    Timecop.travel Time.parse "January 1"
    food_menu = create(:food_menu, base_price: 6.50, kena_gst: false, kena_delivery_fee: false)

    Timecop.travel Time.parse "February 1"
    order_chit = create(:order_chit)
    order_item = create(:order_item, food_menu: food_menu, order_chit: order_chit)

    Timecop.travel Time.parse "March 1"
    food_menu.update(base_price: 10.00)
    expect(order_item.amount).to eq 6.50

    Timecop.travel Time.parse "April 1"
    food_menu.update(kena_gst: true)
    expect(order_item.amount).to eq 6.50

    Timecop.travel Time.parse "May 1"
    food_menu.update(kena_delivery_fee: true)
    expect(order_item.amount).to eq 6.50

    Timecop.return
  end

  it "won't change the amount on older chit if price drops and fees are abolished later", versioning: true do
    Timecop.travel Time.parse "January 1"
    food_menu = create(:food_menu, base_price: 10, kena_gst: true, kena_delivery_fee: true)

    Timecop.travel Time.parse "February 1"
    order_chit = create(:order_chit)
    order_item = create(:order_item, food_menu: food_menu, order_chit: order_chit)

    Timecop.travel Time.parse "March 1"
    food_menu.update(base_price: 6.50)
    expect(order_item.amount).to eq 11.6

    Timecop.travel Time.parse "April 1"
    food_menu.update(kena_gst: true)
    expect(order_item.amount).to eq 11.6

    Timecop.travel Time.parse "May 1"
    food_menu.update(kena_delivery_fee: true)
    expect(order_item.amount).to eq 11.6

    Timecop.return
  end

end
