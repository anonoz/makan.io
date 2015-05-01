class Vendor::OrderChitsController < Vendor::MainController
  before_action :set_order_chit, except: [:index, :new, :create]
  
  def index
    @order_chits = @vendor.order_chits.order(created_at: :desc)
  end

  def show
  end

  def new
    @food_menus = @vendor.food_menus.includes(:food_options)
    @food_options = @vendor.food_options.includes(:food_option_choices)

    @food_options_json = ActiveModel::ArraySerializer.
                           new(@food_options, each_serializer: Food::OptionSerializer).
                           to_json
  end

  def create
    @order_chit = @vendor.order_chits.new(new_order_chit_params)

    if @order_chit.save
      render json: @order_chit
    else
      render json: @order_chit.errors
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_order_chit
    @order_chit = @vendor.order_chits.find_by_id params[:id]
  end

  def new_order_chit_params
    params.require(:order_chit).permit(
      :customer_user_id,
      :customer_address_id,
      :offline_customer_name,
      :offline_customer_address,
      :offline_customer_phone,
      :items_attributes => [
        :food_menu_id,
        :quantity,
        :remarks,
        :extras_attributes => [
          :food_option_choice_id,
          :quantity
        ]
      ]
    )
  end
end
