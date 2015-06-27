class Vendor::OrderChitsController < Vendor::MainController
  before_action :set_data_for_forms, only: [:new, :edit]
  before_action :set_order_chit, except: [:index, :new, :create]
  
  def index
    @order_chits = @vendor.order_chits.
                           paginate(page: params[:page]).
                           includes(:customer_user,
                                    :items => [:orderable, :extras => [:food_option_choice]]).
                           order(created_at: :desc)
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @order_chit, serializer: Order::ChitSerializer }
    end
  end

  def new
    @order_chit = Order::Chit.new
  end

  def create
    @order_chit = @vendor.order_chits.new(new_order_chit_params.merge({from_web: false}))

    if @order_chit.save
      redirect_to vendor_root_path, flash: {success: "Ordered"}
    else
      render json: @order_chit.errors
    end
  end

  def edit
    @items = @order_chit.items.includes(:orderable, :extras => [:food_option_choice])
    @items_json = ActiveModel::ArraySerializer.
                    new(@items, each_serializer: Order::ItemSerializer).
                    to_json
  end

  def update
    @order_chit.attributes = update_order_chit_params
    
    if @order_chit.save
      redirect_to vendor_order_chit_path(@order_chit),
                  flash: {success: "Chit updated."}
    else
      render "edit", flash: {error: @order_chit.errors.full_messages.to_sentence}
    end
  end

  def destroy
  end

  def reject
    change_chit_status_to :reject
  end

  def accept
    change_chit_status_to :accept
  end

  def deliver
    change_chit_status_to :deliver
  end

  def finish
    change_chit_status_to :finish
  end

  private

  def set_data_for_forms
    @food_menus = @vendor.food_menus.includes(:vendor_subvendor, :food_options => [:food_option_choices])
    @food_options = @vendor.food_options.includes(:food_option_choices)
    @subvendors = @vendor.subvendors

    @food_menus_json = ActiveModel::ArraySerializer.
                         new(@food_menus, each_serializer: Food::MenuSerializer).
                         to_json
    @food_options_json = ActiveModel::ArraySerializer.
                           new(@food_options, each_serializer: Food::OptionSerializer).
                           to_json
    @subvendors_json = Vendor::SubvendorSerializer.list(@subvendors).to_json
  end

  def set_order_chit
    @order_chit = @vendor.order_chits.find_by_id params[:id]
  end

  def change_chit_status_to(new_status)
    begin
      @order_chit.send("#{ new_status }!")

      redirect_to vendor_order_chit_path(@order_chit),
                flash: {success: "Chit is now #{ @order_chit.status }"}
    rescue AASM::InvalidTransition => e
      redirect_to vendor_order_chit_path(@order_chit),
                  flash: {error: e.message}
    end
  end

  def new_order_chit_params
    params.require(:order_chit).permit(
      :customer_user_id,
      :customer_address_id,
      :offline_customer_name,
      :offline_customer_address,
      :offline_customer_phone,
      :remarks,
      :items_attributes => [ # Order::Item
        :orderable_id,
        :food_menu_id,
        :quantity,
        :remarks,
        :extras_attributes => [ # Order::ItemExtra
          :food_option_choice_id,
          :quantity
        ],
        :custom_item_attributes => [ # Order::CustomItem
          :title,
          :base_price_cents,
          :base_price,
          :vendor_subvendor_id,
          :subvendor_price_cents,
          :subvendor_price,
          :kena_gst,
          :kena_delivery_fee
        ]
      ]
    )
  end

  def update_order_chit_params
    params.require(:order_chit).permit(
      :customer_user_id,
      :customer_address_id,
      :offline_customer_name,
      :offline_customer_address,
      :offline_customer_phone,
      :remarks,
      :items_attributes => [
        :id,
        :orderable_id,
        :food_menu_id,
        :quantity,
        :remarks,
        :_destroy,
        :extras_attributes => [
          :id,
          :food_option_choice_id,
          :quantity,
          :_destroy
        ],
        :custom_item_attributes => [
          :id,
          :title,
          :base_price_cents,
          :base_price,
          :vendor_subvendor_id,
          :subvendor_price_cents,
          :subvendor_price,
          :kena_gst,
          :kena_delivery_fee,
          :_destroy
        ]
      ]
    )
  end
end
