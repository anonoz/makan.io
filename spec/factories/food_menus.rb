FactoryGirl.define do
  factory :food_menu, :class => 'Food::Menu' do
  	association :vendor_subvendor
  	association :food_category
    title "Nasi Lemak Ayam Rendang"
    base_price 150
  end

end
