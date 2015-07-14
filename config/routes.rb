Rails.application.routes.draw do

  constraints(:host => /makanio.herokuapp.com/) do
    match "/(*path)" => redirect {|params, req| "https://www.makan.io/#{params[:path]}"},  via: [:get, :post]
  end

  # Temporary
  # if Rails.env.production?
  if true
    root 'prelaunch#index'
  else
    root 'homepage#index'
  end

  # Marketplace
  devise_for :customers, class_name: "Customer::User", path: 'me',
             controllers: { omniauth_callbacks: "customers/omniauth_callbacks" }

  scope module: :marketplace do
    scope '/:city', constraints: {city: /setapak|sungailong/}, as: :city do
      get "/" => "city#show"
      
      resource :cart do
        resources :items, controller: "cart_items"
      end

      resources :menus, only: [:index, :show], path: "foods"
    end
  end

  # Admin Panel
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

  devise_for :subvendor, class_name: "Vendor::Subvendor"
  namespace "subvendor" do
    get "/" => "main#index", as: :root
  end

  if Rails.env.development?
    match "dojo" => "dojo#main", via: [:get, :post]
  end

end
