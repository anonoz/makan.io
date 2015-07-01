Rails.application.routes.draw do

  constraints(:host => /makanio.herokuapp.com/) do
    match "/(*path)" => redirect {|params, req| "https://www.makan.io/#{params[:path]}"},  via: [:get, :post]
  end

  root 'prelaunch#index'

  devise_for :customer, class_name: "Customer::User", path: 'me'
  scope '/:city', constraints: {city: /setapak|sungailong/} do
    get "/" => "dojo#main"
  end

  devise_for :vendor, class_name: "Vendor::User"
  namespace "vendor" do
    get "/" => "main#index", as: :root
    resources :order_chits do
      member { post :reject, :accept, :deliver, :finish }
    end
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

  devise_for :subvendors, class_name: "Vendor::Subvendor"
  namespace "subvendor" do
    get "/" => "main#index", as: :root
  end

  if Rails.env.development?
    match "dojo" => "dojo#main", via: [:get, :post]
  end

end
