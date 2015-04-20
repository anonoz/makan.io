FactoryGirl.define do
  factory :food_menu, :class => 'Food::Menu' do
  	association :vendor_subvendor
  	association :food_category
    title "Nasi Lemak Ayam Rendang"
    base_price 1.5
    availability true
  end

end
