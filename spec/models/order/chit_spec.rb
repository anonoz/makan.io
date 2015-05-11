require 'spec_helper'

describe Order::Chit do
  it "is invalid without a vendor id" do
    expect(build(:order_chit, vendor_vendor_id: nil)).to be_invalid
  end

  it "is valid with a customer user id" do
    expect(build(:order_chit)).to be_valid
  end

  it "is also valid without a customer user id" do
    expect(build(:order_chit_for_offline_guest)).to be_valid
  end

  it "haha"

  it "returns delivery destination info correctly for offline customer" do
    order_chit = build(:order_chit,
                       customer_user: nil,
                       customer_address: nil,
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
  
end
