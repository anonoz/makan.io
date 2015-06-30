FactoryGirl.define do
  factory :food_menu, :class => 'Food::Menu' do
  	association :vendor_subvendor
  	association :food_category
    title "Nasi Lemak"
    base_price 3
    subvendor_price 2
    availability true
    kena_gst false
    kena_delivery_fee false
  end

end
