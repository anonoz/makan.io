class Vendor::FoodOptionsController < Vendor::MainController
  before_action :set_food_option, only: [:show, :edit, :update, :destroy]

  def index
    @food_options = @vendor.food_options
    @new_food_option = Food::Option.new
  end

  def show
    @choices = @food_option.choices
  end

  def new
    @food_option = @vendor.food_options.new
  end

  def create
    @food_option = @vendor.food_options.new(food_option_params)

    if @food_option.save
      redirect_to vendor_food_options_path,
                  flash: {success: "#{ @food_option.title } created."}
    else
      redirect_to vendor_food_options_path,
                  flash: {error: @food_option.errors.full_messages.to_sentence}
    end
  end

  def edit

  end

  def update
    if @food_option.update(food_option_params)
      redirect_to vendor_food_option_path(@food_option),
                  flash: {success: "#{ @food_option.title } updated."}
    else
      redirect_to vendor_food_option_path(@food_option),
                  flash: {error: @food_option.errors.full_messages.to_sentence}
    end
  end

  def destroy
    if @food_option.destroy
      redirect_to vendor_food_options_path, 
                  flash: {success: "Food Option deleted."}
    else
      redirect_to vendor_food_options_path, 
                  flash: {error: "Cannot delete."}
    end
  end

  private

  def set_food_option
    @food_option = @vendor.food_options.find_by_id params[:id]
  end

  def food_option_params
    params.require(:food_option).permit(:title, :kind, :min, :max)
  end

end