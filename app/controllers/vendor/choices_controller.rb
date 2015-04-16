class Vendor::ChoicesController < Vendor::MainController
  before_action :set_food_option
  before_action :set_choice, only: [:show, :edit, :update, :destroy]

  def index
    @choices = @food_option.choices
  end

  def show
  end

  def new
  end

  def create
    @choice = @food_option.choices.new choice_params

    if @choice.save
    	
    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_food_option
    @food_option = @vendor.food_options.find_by_id params[:food_option_id]
  end

  def set_choice
    @choice = @food_option.choices.find_by_id params[:id]
  end

  def choice_params
    params.require(:food_option_choice).
           permit(:title, :min, :max, :unit_amount, :default_quantity,
           	      :default_chosen)
  end

end