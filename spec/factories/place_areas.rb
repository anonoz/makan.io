FactoryGirl.define do
  factory :place_area, :class => "Place::Area" do
    name "Cyberia"
    association :place_city
  end

end
