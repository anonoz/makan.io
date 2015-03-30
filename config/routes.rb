Rails.application.routes.draw do

  constraints(:host => /makanio.herokuapp.com/) do
    match "/(*path)" => redirect {|params, req| "https://www.makanio.com/#{params[:path]}"},  via: [:get, :post]
  end
  
  devise_for :vendor_users, class_name: "Vendor::User"
  devise_for :users, class_name: "Customer::User"
  root 'prelaunch#index'
end
