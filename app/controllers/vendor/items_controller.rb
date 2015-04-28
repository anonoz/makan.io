class Vendor::ItemsController < Vendor::MainController
  def index
    
  end

  def new
    @food_menus = @vendor.food_menus
  end

  def create
    
  end

  private

  def set_cart
    @cart = session[:vendor_cart]
  end

end
