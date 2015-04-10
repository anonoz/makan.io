FactoryGirl.define do
  factory :food_menu_option, :class => 'Food::MenuOption' do
    association :food_menu
    association :food_option
  end

end
