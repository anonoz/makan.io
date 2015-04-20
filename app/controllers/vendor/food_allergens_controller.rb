class Vendor::FoodAllergensController < Vendor::MainController
  before_action :set_allergen, only: [:show, :edit, :update, :destroy]

  def index
    @allergens = @vendor.food_allergens
  end

  def show
  end

  def new
  end

  def create
    @allergen = @vendor.food_allergens.new(allergen_params)

    if @allergen.save
      redirect_to vendor_food_allergens_path,
                  flash: {success: "Created #{ @allergen.title }"}
    else
      redirect_to vendor_food_allergens_path,
                  flash: {error: @allergen.errors.full_messages.to_sentence}
    end
  end

  def edit
  end

  def update
    if @allergen.update allergen_params
      redirect_to vendor_food_allergens_path,
                  flash: {success: "Updated #{ @allergen.title }"}
    else
      redirect_to vendor_food_allergens_path,
                  flash: {error: @allergen.errors.full_messages.to_sentence}
    end
  end

  def destroy
    if @allergen.destroy
      redirect_to vendor_food_allergens_path,
                  flash: {success: "Deleted #{ @allergen.title }"}
    else
      redirect_to vendor_food_allergens_path,
                  flash: {error: @allergen.errors.full_messages.to_sentence}
    end
  end

  private

  def set_allergen
    @allergen = @vendor.food_allergens.find_by_id params[:id]
  end

  def allergen_params
    params.require(:food_allergen).permit(:title)
  end

end
