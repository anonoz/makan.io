class Vendor::CartController < Vendor::MainController
  def show
    @cart = session[:vendor_cart]
  end

  def new
    @cart = session[:vendor_cart] ||= {order_items: []}
  end

  def edit
  end

  def update
  end

  def destroy
    session[:vendor_cart] = nil
  end
end
