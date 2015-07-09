class Marketplace::CartsController < Marketplace::MainController
  def show
    
  end

  def destroy
    reset_cart
    redirect_to city_cart_path(@city), flash: {success: "Cart is cleared!"}
  end

  private

  def reset_cart
    @order_chit.items.clear
  end
end
