class Vendor::FoodMenusController < Vendor::MainController

  def index
    @menus = @vendor.food_menus
  end

  def show
    @menu = @vendor.food_menus.find_by_id(params[:id])
  end

  def new
    @menu = @vendor.food_menus.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
