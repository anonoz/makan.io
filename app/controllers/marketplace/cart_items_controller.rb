class Marketplace::CartItemsController < Marketplace::MainController
  def create
    create_order_item
    redirect_to city_cart_path(@city), flash: {success: "#{ @order_item.orderable.title } is added."}
  end

  private

  def cart_item_params
    params.require(:order_item).permit(
      :orderable_id, :orderable_type
    )
  end

  def create_order_item
    @order_item = Order::Item.new(cart_item_params)
    @order_chit.items << @order_item
    save_order_chit
  end
end
