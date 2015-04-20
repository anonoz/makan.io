Rails.application.routes.draw do

  constraints(:host => /makanio.herokuapp.com/) do
    match "/(*path)" => redirect {|params, req| "https://www.makan.io/#{params[:path]}"},  via: [:get, :post]
  end

  root 'prelaunch#index'

  devise_for :vendor, class_name: "Vendor::User"
  devise_for :user, class_name: "Customer::User"

  namespace "vendor" do
    get "/" => "main#index", as: :root
    resources :subvendors
    resources :subvendors_opening_hours
    resources :subvendors_closing_hours
    resources :food_menus
    resources :food_categories
    resources :food_options do
      resources :choices
    end
    resources :food_allergens
    resources :vendor_users
    resources :areas
  end

end
