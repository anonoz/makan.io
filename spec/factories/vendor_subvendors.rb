FactoryGirl.define do
  sequence :email do |n|
    "subvendor_#{ n }@gmail.com"
  end

  factory :vendor_subvendor, :class => 'Vendor::Subvendor' do
    association :vendor_vendor
    title "Ah Beng Nasi Lemak"
    email
    password "hahahaha"
    password_confirmation "hahahaha"
  end

end
