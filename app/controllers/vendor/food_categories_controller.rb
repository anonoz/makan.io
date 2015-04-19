class Vendor::FoodCategoriesController < Vendor::MainController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = @vendor.food_categories
    @new_category = Food::Category.new
  end

  def show
  end

  def new
    @category = @vendor.food_categories.new
  end

  def create
    @category = @vendor.food_categories.new(category_params)

    if @category.save
      redirect_to vendor_food_categories_path,
                  flash: {success: "Category #{ @category.title } created."}
    else
      redirect_to vendor_food_categories_path,
                  flash: {error: @category.errors.full_messages.to_sentence}
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to vendor_food_categories_path,
                  flash: {success: "Category #{ @category.title } updated."}
    else
      redirect_to edit_vendor_food_category_path(@category),
                  flash: {error: @category.errors.full_messages.to_sentence}
    end
  end

  def destroy
    if @category.destroy
      redirect_to vendor_food_categories_path, 
                  flash: {success: "Category #{ @category.title } is destroyed."}
    else
      redirect_to vendor_food_categories_path,
                  flash: {error: @category.errors.full_messages.to_sentence}
    end
  end

  private

  def set_category
    @category = @vendor.food_categories.find_by_id(params[:id])
  end

  def category_params
    params.require(:food_category).permit(:title)
  end
end
