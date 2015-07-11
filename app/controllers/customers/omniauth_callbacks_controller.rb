class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # @customer_user = Customer::User.from_omniauth(request.env["omniauth.auth"])
    render json: request.env["omniauth.auth"]

    # if @customer_user.persisted?

    # else
    # end
  end
end
