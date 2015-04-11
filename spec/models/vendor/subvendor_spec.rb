require 'spec_helper'

describe Vendor::Subvendor do
  it "is invalid without belonging to vendor_vendor" do
    vendorless_sub = build(:vendor_subvendor, vendor_vendor: nil)
    vendorless_sub.valid?
    expect(vendorless_sub.errors[:vendor_vendor]).to(
      include "can't be blank")
  end
end
