FactoryGirl.define do
  factory :food_option_choice, :class => 'Food::OptionChoice' do
    food_option_id 1
title "MyString"
min 1
max 1
unit_amount 1
default_quantity 1
default_chosen false
  end

end
