class Marketplace::CartItemsController < Marketplace::MainController
  def create
    render json: cart_item_params
  end

  private

  def cart_item_params
    params.require(:order_item).permit(
      :orderable_id, :orderable_type
    )
  end
end
