require 'spec_helper'

describe Promo::Chain do
  let(:order_chit) { create(:order_chit) }

  it "doesn't initialize without order chit" do
    expect {Promo::Chain.new}.to raise_error ArgumentError
    expect {Promo::Chain.new "arbitrary shit"}.to raise_error ArgumentError
  end

  it "initializes with proper order chit" do
  	expect {Promo::Chain.new(order_chit)}.not_to raise_error
  end
end
