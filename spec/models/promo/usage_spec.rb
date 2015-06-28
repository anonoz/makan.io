require 'spec_helper'

describe Promo::Usage do
  let(:promo_usage) { create(:promo_usage) }

  it "is valid with order chit" do
    expect(promo_usage).to be_valid
  end

  it "is invalid without an order chit" do
    promo_usage.update(order_chit: nil)
    expect(promo_usage.errors[:order_chit]).to include "can't be blank"
  end
end
