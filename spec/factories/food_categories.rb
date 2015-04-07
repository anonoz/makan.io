FactoryGirl.define do
  factory :food_category, :class => 'Food::Category' do
    title "Nasi Lemak"

    trait :nasi_goreng do
      title "Nasi Goreng"
    end
  end

end
