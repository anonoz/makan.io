class Marketplace::MenusController < Marketplace::MainController
  before_action :filter_food_menus, only: [:index]
  before_action :set_menu, :build_order_item, only: [:show]

  def index
    @title = "Setapak Food Delivery by Running Man"
  end

  def show
    @title = "#{ @menu } Delivery in Setapak"
  end

  private

  def set_vendor
    @vendor = Vendor::Vendor.find_by(city: params[:city])
  end

  def filter_food_menus
    set_vendor
    @categories = @vendor.food_categories.includes(:food_menus)
    # @menus = @vendor.food_menus
  end

  def set_menu
    set_vendor

    begin
      @vendor = Vendor::Vendor.find_by(city: params[:city])
      @menu = @vendor.food_menus.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise_not_found(e)
    end
  end

  def build_order_item
    @order_item = Order::Item.new(orderable: @menu)
  end
end
