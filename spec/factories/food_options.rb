FactoryGirl.define do
  factory :food_option, :class => 'Food::Option' do
    title "Blank Option Title"
    vendor_vendor
    kind "choose_multiple"

    trait :choose_multiple do
      kind "choose_multiple"
      title "Meats"
      min   0   # You can have no meat at all
      max   2   # Or at most 2 you carnivore
    end

    trait :choose_one do # radio button
      kind "choose_one"
      title "Sambal"
    end

    trait :quantities do
      kind "quantities"
      title "Eggs"
    end

    factory :food_option_with_choose_multiple, traits: [:choose_multiple]
    factory :food_option_with_choose_one, traits: [:choose_one]
    factory :food_option_with_quantities, traits: [:quantities]
  end

end
