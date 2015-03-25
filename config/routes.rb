Rails.application.routes.draw do
  devise_for :vendor_users, class_name: "Vendor::User"
  devise_for :users, class_name: "Customer::User"
  root 'prelaunch#index'
end
