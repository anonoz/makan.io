class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :set_locale

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :vendor
      "vendor_sign_in"
    elsif devise_controller? && resource_name == :user
      false
    else
      "application"
    end
  end

  def current_ability
    if vendor_signed_in?
      @current_ability ||= VendorAbility.new(current_vendor)
    else
      @current_ability ||= CustomerAbility.new(current_user)
    end
  end
  
  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
