FactoryGirl.define do
  factory :food_option, :class => 'Food::Option' do
    title "Blank Option Title"
    jenis 1

    trait :checkboxes do
      jenis 1
      title "Meats"
      min   0   # You can have no meat at all
      max   2   # Or at most 2 you carnivore
    end

    trait :numbers do
      jenis 2
      title "Eggs"
    end

    trait :radio_buttons do # radio button
      jenis 3
      title "Sambal"
    end

    factory :food_option_with_checkboxes, traits: [:checkboxes]
    factory :food_option_with_numbers, traits: [:numbers]
    factory :food_option_with_radio_buttons, traits: [:radio_buttons]
  end

end
