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
    @order_chits = @vendor.order_chits

    @incoming_orders  = Order::ChitDecorator.decorate_collection @order_chits.incoming_today
    @rejected_orders  = Order::ChitDecorator.decorate_collection @order_chits.rejected_today
    @accepted_orders  = Order::ChitDecorator.decorate_collection @order_chits.accepted_today
    @delivered_orders = Order::ChitDecorator.decorate_collection @order_chits.delivered_today
  end

end
