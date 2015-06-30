FactoryGirl.define do
  factory :food_option_choice, :class => 'Food::OptionChoice' do
    food_option
    title "Food Option Choice Title"
    min 0
    max 0
    subvendor_price 0.50
    unit_amount 1.00
    default_quantity 0
    default_chosen false

    trait :for_checkboxes do
      association :food_option_choice, :checkboxes
      title "Chicken Rendang"
      unit_amount 3.50
      default_chosen false
    end

    trait :for_numbers do
      association :food_option_choice, :numbers
      title "Boiled Egg"
      min 0
      max 5
      default_quantity 1
    end

    trait :for_radio_buttons do
      association :food_option_choice, :radio_button
      title "Normal"
      unit_amount 0
      default_chosen true
    end

    factory :food_option_choice_for_checkboxes, traits: [:for_checkboxes]
    factory :food_option_choice_for_numbers, traits: [:for_numbers]
    factory :food_option_choice_for_radio_buttons, traits: [:for_radio_buttons]
  end

end
