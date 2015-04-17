class Vendor::ChoicesController < Vendor::MainController
  before_action :set_food_option
  before_action :set_choice, only: [:show, :edit, :update, :destroy]

  def index
    @choices = @food_option.choices
    @table_partial = case @food_option.kind
      when Food::Option::CHOOSE_MULTIPLE then "choices_for_multiple_choices"
      when Food::Option::CHOOSE_ONE then "choices_for_single_choice"
      when Food::Option::QUANTITIES then "choices_for_quantities"
    end
  end

  def show
  end

  def new
  end

  def create
    @choice = @food_option.choices.new choice_params

    if @choice.save
    	redirect_to vendor_food_option_choices_path(@food_option),
                  flash: {success: "Choice #{ @choice.title } created."}
    else
      redirect_to vendor_food_option_choices_path(@food_option),
                  flash: {error: @choice.errors.full_messages.to_sentence }
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @choice.destroy
      redirect_to vendor_food_option_choices_path(@food_option),
                  flash: {success: "Choice #{ @choice.title } archived."}
    else
      redirect_to vendor_food_option_choices_path(@food_option),
                  flash: {error: "Choice #{ @choice.title } cannot be archived."}
    end
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