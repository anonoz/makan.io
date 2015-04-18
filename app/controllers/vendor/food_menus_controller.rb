class Vendor::FoodMenusController < Vendor::MainController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = @vendor.food_menus
  end

  def show
    @menu = @vendor.food_menus.find_by_id(params[:id])
  end

  def new
    @vendor_food_options = @vendor.food_options

    if session[:food_menu]
      @menu = Food::Menu.new(session[:food_menu])
      session[:food_menu] = nil
      @menu.valid?
    else
      @menu = Food::Menu.new
    end
  end

  def create
    @menu = Food::Menu.new menu_params
    
    if @menu.save
      redirect_to vendor_food_menus_path, flash: {success: "#{ @menu.title } created."}
    else
      session[:food_menu] = params[:food_menu]
      redirect_to new_vendor_food_menu_path, flash: {error: @menu.errors.full_messages.to_sentence}
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @menu.destroy
      redirect_to vendor_food_menus_path, flash: {success: "#{ @menu.title } is deleted."}
    else
      redirect_to vendor_food_menus_path, flash: {error: @menu.errors.full_messages.to_sentence}
    end
  end

  private

  def set_menu
    @menu = @vendor.food_menus.find_by_id params[:id]
  end

  def menu_params
    params.require(:food_menu).
           permit(:title, :base_price, :food_category_id, :vendor_subvendor_id,
                  :feature_photo, :food_option_ids => [])
  end
  
end
