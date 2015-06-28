require 'spec_helper'

describe Promo::Adjustment do
  context "#to_usage" do
    it "returns a Promo::Usage instance" do
      expect(Promo::Adjustment.new.to_usage).to be_an_instance_of Promo::Usage
    end
  end
end
