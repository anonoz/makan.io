class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @customer_user = Customer::User.from_omniauth(request.env["omniauth.auth"])

    if @customer_user.persisted?
      sign_in @customer_user
      redirect_to request.env["omniauth.origin"] || root_path, flash: {success: "Welcome, #{ @customer_user.name }."}
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_customer_registration_url
    end
  end

  private
end
