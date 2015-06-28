require 'spec_helper'

describe Promo::StudentDeliveryFeeWaiver do
  let(:customer_user) { create(:customer_user) }
  let(:order_chit) { create(:order_chit) }
  let(:nasi_lemak) { create(:food_menu, kena_delivery_fee: false, base_price: 2) }
  let(:maggi_goreng) { create(:food_menu, kena_delivery_fee: true, base_price: 4) }

  it "doesn't initialize without order chit" do
    expect {Promo::StudentDeliveryFeeWaiver.new}.to raise_error ArgumentError
    expect {Promo::StudentDeliveryFeeWaiver.new "arbitrary shit"}.to raise_error ArgumentError
  end

  it "initializes with proper order chit" do
  	expect {Promo::StudentDeliveryFeeWaiver.new(order_chit)}.not_to raise_error
  end

  it "is eligible if order is from web and user is student" do
    customer_user.update(student: true)
    order_chit.update(customer_user: customer_user)
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_eligible?).to be_truthy
  end

  it "is ineligible if order is from web and user is not student" do
    order_chit.update(customer_user: customer_user)
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_eligible?).to be_falsy
  end
  
  it "is eligible if order if from POS and caller is student" do
    order_chit.update(from_web: false, caller_is_student: true)
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_eligible?).to be_truthy
  end

  it "is ineligible if order is from POS and caller is not student" do
    order_chit.update(from_web: false, caller_is_student: false)
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_eligible?).to be_falsy
  end

  it "is actionable if order has 1 or more items with delivery fee" do
    order_chit.items << create(:order_item, orderable: maggi_goreng)
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_actionable?).to be_truthy
  end

  it "is unactionable if order has no item with delivery fee" do
  	order_chit.items << create(:order_item, orderable: nasi_lemak)
  	expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).is_actionable?).to be_falsy
  end

  it "returns adjustment if promotion if eligible and actionable" do
    maggi_order = create(:order_item, orderable: maggi_goreng)
    order_chit.update(from_web: false, caller_is_student: true, items: [maggi_order])
    expect(Promo::StudentDeliveryFeeWaiver.new(order_chit).apply).to be_any
  end

  it "raises error if attempt to apply when promo is ineligible" do
    order_chit.update(customer_user: customer_user)
    expect {Promo::StudentDeliveryFeeWaiver.new(order_chit).apply}.to raise_error Promo::IneligibilityError
  end

  it "raises error if attempt to apply when promo is ineligible" do
  	customer_user.update(student: true)
    order_chit.update(customer_user: customer_user)
    expect {Promo::StudentDeliveryFeeWaiver.new(order_chit).apply}.to raise_error Promo::ActionabilityError
  end

end
