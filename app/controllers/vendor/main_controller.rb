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
    @order_chits = @vendor.order_chits.reverse_order

    @incoming_orders  = @order_chits.ordered
    @rejected_orders  = @order_chits.rejected
    @accepted_orders  = @order_chits.accepted
    @delivered_orders = @order_chits.delivered
  end

end
