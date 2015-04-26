class Vendor::FoodMenusController < Vendor::MainController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_food_options_and_allergens, only: [:new, :edit]

  def index
    @menus = @vendor.food_menus.includes(:vendor_subvendor, :food_category)
  end

  def show
    redirect_to action: :edit
  end

  def new
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
    @menu = @vendor.food_menus.find_by_id params[:id]

    if session[:food_menu]
      @menu.attributes = session[:food_menu]
      session[:food_menu] = nil
    end
  end

  def update
    if @menu.update(menu_params)
      redirect_to vendor_food_menus_path, flash: {success: "#{ @menu.title } updated."}
    else
      session[:food_menu] = menu_params
      redirect_to edit_vendor_food_menu_path(@menu), flash: {error: @menu.errors.full_messages.to_sentence}
    end
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

  def set_food_options_and_allergens
    @vendor_food_options = @vendor.food_options
    @vendor_food_allergens = @vendor.food_allergens
  end

  def menu_params
    params.require(:food_menu).
           permit(:title, :base_price, :food_category_id, :vendor_subvendor_id,
                  :halal, :kena_gst, :kena_delivery_fee, :feature_photo,
                  :availability,
                  :food_option_ids => [], :food_allergen_ids => [])
  end
  
end
