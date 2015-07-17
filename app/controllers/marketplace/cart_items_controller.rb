class Marketplace::CartItemsController < Marketplace::MainController
  def create
    create_order_item
    # params_json
    redirect_to city_cart_path(@city), flash: {success: "#{ @order_item.orderable.title } has been added."}
  end

  private

  def cart_item_params
    params.require(:order_item).permit(
      :food_menu_id,
      :quantity,
      :remarks,
      :extras_attributes => [
        :food_option_choice_id,
        :quantity,
        :id,
        :_destroy
      ]
    )
  end

  def create_order_item
    @order_item = Order::Item.new(cart_item_params)
    @order_chit.items << @order_item
    save_order_chit
  end

end
