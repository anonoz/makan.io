require 'spec_helper'

describe Order::Chit do
  let(:order_chit) { create(:order_chit) }

  it "is invalid without a vendor id" do
    expect(build(:order_chit, vendor_vendor_id: nil)).to be_invalid
  end

  it "is valid with a customer user id" do
    expect(build(:order_chit)).to be_valid
  end

  it "is also valid without a customer user id" do
    expect(build(:order_chit_for_offline_guest)).to be_valid
  end

  context "AASM" do
    it "jumps from ordered to rejected when reject event happens" do
      order_chit = build(:order_chit)
      order_chit.reject
      expect(order_chit.status).to eq "rejected"
    end

    it "sets state_updated_at when state changes" do
      Timecop.freeze Time.local 2015, 2, 1, 12, 00
      
      order_chit.reject!
      expect(order_chit.state_updated_at).to eq Time.new(2015, 2, 1, 12, 00)

      Timecop.return
    end
  end
  
  it "returns delivery destination info correctly for offline customer" do
    order_chit = build(:order_chit,
                       customer_user: nil,
                       customer_address: nil,
                       from_web: false,
                       offline_customer_name: "Ah Beng",
                       offline_customer_address: "PV10 A-8-8",
                       offline_customer_phone: "017-3009142")

    info = order_chit.delivery_destination_info

    expect(info[:name]).to eq "Ah Beng"
    expect(info[:address]).to eq "PV10 A-8-8"
    expect(info[:phone]).to eq "017-3009142"
  end

  it "returns delivery destination info correctly for online customer" do
    user = create(:customer_user)
    address = create(:customer_address, customer_user: user)
    order_chit = build(:order_chit, customer_user: user, customer_address: address)

    info = order_chit.delivery_destination_info

    expect(info[:name]).to eq user.name
    expect(info[:address]).to eq address.human_readable
    expect(info[:phone]).to eq user.phone
  end

  context "Editability" do
    it "allows updates if order is not yet delivered" do
      expect(order_chit.update(offline_customer_name: "Test")).to be_truthy
    end

    it "disallows update if order is delivered" do
      order_chit.accept!
      order_chit.deliver!
      expect(order_chit.update(offline_customer_name: "Test")).to be_falsy
    end
    
    it "disallows update if order is finished" do
      order_chit.accept!
      order_chit.deliver!
      order_chit.finish!
      expect(order_chit.update(offline_customer_name: "Test")).to be_falsy
    end
  end

  it "has 2 order items upon saving if 2 order items are added by << create(:order_item)" do
    order_chit = build(:order_chit)
    order_chit.items << create(:order_item)
    order_chit.items << create(:order_item)
    order_chit.save

    expect(order_chit.items.count).to eq 2
  end

  it "has order items added via item creation and update items' order chit id" do
    3.times { create(:order_item, order_chit_id: order_chit.id) }

    expect(order_chit.items.count).to eq 3
  end

  it "selects orders placed today for scope :today" do
    yesterday_chit = create(:order_chit, created_at: Time.zone.parse("2015-06-28 11:00"))
    today_chit = create(:order_chit, created_at: Time.zone.parse("2015-06-29 11:00"))
    tomorrow_chit = create(:order_chit, created_at: Time.zone.parse("2015-06-30 11:00"))

    Timecop.travel Time.local 2015, 6, 29, 12, 00

    expect(Order::Chit.today).to eq [today_chit]

    Timecop.return
  end

  it "selects incoming orders placed today for scope :incoming_today in reverse order" do
    today_incoming_chit = create(:order_chit, status: :ordered)
    today_incoming_chit_2 = create(:order_chit, status: :ordered)
    today_rejected_chit = create(:order_chit, status: :rejected)

    expect(Order::Chit.incoming_today).to eq [today_incoming_chit_2, today_incoming_chit]
  end

  it "really deletes itself and associated item from database when wipe_from_database! is called" do
    order_chit = create(:order_chit)
    order_item = create(:order_item, order_chit: order_chit)

    expect {
      order_chit.wipe_from_database!
    }.to change {
      [Order::Chit.with_deleted.count, Order::Item.with_deleted.count]
    }.from([1, 1]).to([0, 0])
  end
  
end
