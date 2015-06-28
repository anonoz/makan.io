FactoryGirl.define do
  factory :promo_usage, :class => 'Promo::Usage' do
    order_chit
    # promo_id 1
    promo_type "Promo::Base"
    adjustment 0
  end

end
