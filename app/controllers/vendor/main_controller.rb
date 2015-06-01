class Vendor::MainController < ApplicationController
  layout "vendor"
  before_action :authenticate_vendor!, :set_vendor

  def index
    @title = "kanban"
    load_kanban
  end

  private

  def set_vendor
    @vendor = current_vendor.vendor
  end

  def user_for_paper_trail
    if vendor_signed_in?
      "vendor_#{ current_vendor.id } #{ current_vendor.email }"
    end
  end

  def load_kanban
    @incoming_orders  = @vendor.order_chits.ordered.includes(:customer_user, :customer_address)
    @rejected_orders  = @vendor.order_chits.rejected.includes(:customer_user, :customer_address)
    @accepted_orders  = @vendor.order_chits.accepted.includes(:customer_user, :customer_address)
    @delivered_orders = @vendor.order_chits.delivered.includes(:customer_user, :customer_address)
  end

end
