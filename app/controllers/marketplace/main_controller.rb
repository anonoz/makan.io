class Marketplace::MainController < ApplicationController
  layout "marketplace"

  before_action :set_city, :set_vendor, :set_order_chit

  private

  def set_city
    @city = params[:city]
  end

  def set_vendor
    @vendor ||= Vendor::Vendor.find_by(city: @city)
  end

  def set_order_chit
    @order_chit ||= find_order_chit_in_session || build_order_chit
  end

  ##
  # Order chit that is not checked out will be cleared out from database every once in
  # a while. If the order_chit_id in session cannot be found in database, we should set
  # session as nil so a new order chit will be built.

  def find_order_chit_in_session
    if chit_in_session = @vendor.order_chits.find_by_id(session[order_chit_session_key])
      chit_in_session
    else
      session[order_chit_session_key] = nil
    end
  end

  def build_order_chit
    Order::Chit.new(vendor_vendor: @vendor, status: :draft)
  end

  def save_order_chit
    @order_chit.save! and session[order_chit_session_key] = @order_chit.id
  end

  def order_chit_session_key
    "chit_for_#{ set_vendor.id }"
  end

  def raise_not_found(e)
    render template: "layouts/marketplace/not_found", status: 404
    raise if Rails.env.development?
  end

end
