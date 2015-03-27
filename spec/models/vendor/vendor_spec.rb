require 'spec_helper'

describe Vendor::Vendor do
  it "is valid when title is present" do
    expect(FactoryGirl.build(:vendor_vendor)).to be_valid
  end

  it "is invalid when title is absent" do
    vendor = FactoryGirl.build(:vendor_vendor, title: nil)
    vendor.valid?
    expect(vendor.errors[:title]).to include("can't be blank")
  end

  it "doesnt give a fuck if you got address or not" do
    expect(FactoryGirl.build(:vendor_vendor, address: nil)).to be_valid
    expect(FactoryGirl.build(:vendor_vendor)).to be_valid
  end

  it "doesnt care if you got phone or not" do
    expect(FactoryGirl.build(:vendor_vendor, phone: nil)).to be_valid
    expect(FactoryGirl.build(:vendor_vendor)).to be_valid
  end

  it "doesnt care if you got email or not" do
    expect(FactoryGirl.build(:vendor_vendor, email: nil)).to be_valid
    expect(FactoryGirl.build(:vendor_vendor)).to be_valid
  end
end
