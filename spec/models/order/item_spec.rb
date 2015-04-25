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
end
