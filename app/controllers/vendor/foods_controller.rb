class Vendor::FoodsController < ApplicationController
  layout "layouts/vendor"
  before_action :set_vendor

  def index
    @menus = @vendor.food_menus
  end

  def show
    @menu = @vendor.food_menus.find_by_id(params[:id])
  end

  def new
    @menu = @vendor.food_menus.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_vendor
    @vendor = current_vendor.vendor
  end
end
