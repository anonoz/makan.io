require 'spec_helper'

describe Order::Item do
  let(:order_chit) { create(:order_chit) }

  it "is invalid without belong to food menu" do
    foodless_item = build(:order_item, orderable: nil)
    foodless_item.valid?
    expect(foodless_item.errors[:orderable]).to(
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
    item = create(:order_item, order_chit: order_chit)
    expect(item.update(quantity: 2)).to be_truthy
    
    order_chit.reject!
    expect(item.update(quantity: 3)).to be_truthy
  end

  it "disallows update if chit is delivered/finished" do
    item = create(:order_item, order_chit: order_chit)

    order_chit.accept!
    order_chit.deliver!
    expect(item.update(quantity: 2)).to be_falsy

    order_chit.finish!
    expect(item.update(quantity: 3)).to be_falsy
  end

  context "Orderable is custom item entry" do
    it "allows custom item entry as orderable" do
      expect(create(:order_item, orderable: build(:order_custom_item))).to be_valid
    end

    it "calculates amount for custom item just fine" do
      custom_item = build(:order_custom_item, base_price: 3)
      order_item = create(:order_item, orderable: custom_item, quantity: 3)
      expect(order_item.amount).to eq 9
    end

    it "calculates amount + delivery fee for custom item" do
      custom_item = build(:order_custom_item, base_price: 3, kena_delivery_fee: true)
      order_item = create(:order_item, orderable: custom_item)
      expect(order_item.amount).to eq 3.30
    end

    it "calculates amount + gst for custom item" do
      custom_item = build(:order_custom_item, base_price: 3, kena_gst: true)
      order_item = create(:order_item, orderable: custom_item)
      expect(order_item.amount).to eq 3.18
    end

    it "takes in custom_item_attributes to be custom item" do
      order_item = build(:order_item, {
        quantity: 2,
        custom_item_attributes: {
          title: "Better Mineral Water",
          base_price: 2.00,
          subvendor_price: 1.00,
          kena_delivery_fee: true
        }
      })

      expect(order_item).to be_valid
      expect(order_item.title).to eq "Better Mineral Water"
      expect(order_item.orderable_type).to eq "Order::CustomItem"
    end
  end

  context "Amount Calculation" do
    it "costs $3 if Nasi Lemak is $3 without extras and other charges" do
      nasi_lemak = create(:food_menu, base_price: 3)
      nasi_lemak_line = build(:order_item, orderable: nasi_lemak)
      expect(nasi_lemak_line.amount).to eq(3)
    end

    it "costs $3.30 if Nasi Lemak is $3 with delivery fee and no extras" do
      nasi_lemak = create(:food_menu, base_price: 3, kena_delivery_fee: true)
      nasi_lemak_line = build(:order_item, orderable: nasi_lemak)
      expect(nasi_lemak_line.amount).to eq(3.3)
    end

    it "costs $3.18 if Nasi Lemak is $3 with GST and no extras" do
      nasi_lemak = create(:food_menu, base_price: 3, kena_gst: true)
      nasi_lemak_line = build(:order_item, orderable: nasi_lemak)
      expect(nasi_lemak_line.amount).to eq(3.18)
    end

    it "costs $3.48 if Nasi Lemak is $3 with both delivery + GST" do
      nasi_lemak = create(:food_menu, base_price: 3,
                          kena_delivery_fee: true, kena_gst: true)
      nasi_lemak_line = build(:order_item, orderable: nasi_lemak)
      expect(nasi_lemak_line.amount).to eq(3.48)
    end

    it "costs $6.50 if Nasi Lemak has Ayam Rendang of $3.50 without fees and taxes" do
      ayam_rendang = create(:food_option_choice, unit_amount: 3.50)
      nasi_lemak_ar = create(:food_menu, base_price: 3.00)
      nasi_lemak_line = create(:order_item, orderable: nasi_lemak_ar)
      ayam_rendang_extra = create(:order_item_extra, food_option_choice: ayam_rendang,
                                  order_item: nasi_lemak_line)

      expect(nasi_lemak_line.amount).to eq(6.50)
    end

    it "costs $7.54 if Nasi Lemak has Ayam Rendang and kena delivery + GST" do
      ayam_rendang = create(:food_option_choice, unit_amount: 3.50)
      nasi_lemak_ar = create(:food_menu, base_price: 3.00, kena_gst: true, kena_delivery_fee: true)
      nasi_lemak_line = create(:order_item, orderable: nasi_lemak_ar)
      ayam_rendang_extra = create(:order_item_extra, food_option_choice: ayam_rendang,
                                  order_item: nasi_lemak_line)

      expect(nasi_lemak_line.amount).to eq(7.54)
    end
  end

  context "PaperTrail for pricing" do
    it "won't change the amount on older chit if base price changes later", versioning: true do
      Timecop.travel Time.parse "November 10"
      food_menu = create(:food_menu, base_price: 6.50)

      Timecop.travel Time.parse "November 25"
      order_item = create(:order_item, orderable: food_menu, order_chit: order_chit)

      Timecop.travel Time.parse "December 25"
      food_menu.update(base_price: 10.00)
      old_order_item = order_item.reload
      expect(old_order_item.amount).to eq 6.50

      Timecop.return
    end

    it "won't change the amount on older chit if GST kicks in later", versioning: true do
      Timecop.travel Time.parse "April 1"
      food_menu = create(:food_menu, base_price: 1)
      order_item = create(:order_item, orderable: food_menu, order_chit: order_chit)

      Timecop.travel Time.parse "May 1"
      food_menu.update(kena_gst: true)

      expect(order_item.amount).to eq 1
    end

    it "won't change the amount on older chit if delivery fee kicks in later", versioning: true do
      Timecop.travel Time.parse "April 1"
      food_menu = create(:food_menu, base_price: 1)
      order_item = create(:order_item, orderable: food_menu, order_chit: order_chit)

      Timecop.travel Time.parse "May 1"
      food_menu.update(kena_delivery_fee: true)

      expect(order_item.amount).to eq 1
    end

    it "won't change the amount on older chit if both fees and price hike kick in later", versioning: true do
      Timecop.travel Time.parse "January 1"
      food_menu = create(:food_menu, base_price: 6.50, kena_gst: false, kena_delivery_fee: false)

      Timecop.travel Time.parse "February 1"
      order_item = create(:order_item, orderable: food_menu, order_chit: order_chit)

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
      order_item = create(:order_item, orderable: food_menu, order_chit: order_chit)

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

  it "really deletes the associated extras from database if wipe_from_database! is called" do
    order_item = create(:order_item)
    order_item.extras << create(:order_item_extra)

    expect {
      order_item.wipe_from_database!
    }.to change {
      Order::ItemExtra.count
    }.from(1).to(0)
  end

  it "really deletes itself when wipe_from_database! is called" do
    order_item = create(:order_item)

    expect {
      order_item.wipe_from_database!
    }.to change {
      Order::Item.with_deleted.count
    }.by -1
  end

end
