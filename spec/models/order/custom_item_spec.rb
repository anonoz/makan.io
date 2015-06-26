require 'spec_helper'

describe Order::CustomItem do
  
  let(:custom_item) { build(:order_custom_item) }

  it "is valid with title" do
    expect(custom_item).to be_valid
  end

  it "is invalid with title" do
    custom_item.title = nil
    custom_item.valid?
    expect(custom_item.errors[:title]).to include "can't be blank"
  end

  it "is valid with & without subvendor" do
  	custom_item.vendor_subvendor = nil
  	expect(custom_item).to be_valid

    custom_item.vendor_subvendor = build(:vendor_subvendor)
    expect(custom_item).to be_valid
  end
end
