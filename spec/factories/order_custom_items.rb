FactoryGirl.define do
  factory :order_custom_item, :class => 'Order::CustomItem' do
    title "Mineral Water"
    base_price_cents 250
    kena_gst false
    kena_delivery_fee false
    subvendor_price_cents 100
  end

end
