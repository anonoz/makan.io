FactoryGirl.define do
  factory :food_option, :class => 'Food::Option' do
    title "MyString"
type 1
min 1
max 1
  end

end
