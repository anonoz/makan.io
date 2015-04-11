class Vendor::FoodCategoriesController < ApplicationController
  layout "layouts/vendor"
  before_action :set_vendor

  def index
    @categories = @vendor.food_categories
    @new_category = Food::Category.new
  end

  def show
    @category = @vendor.food_categories.find_by_id(params[:id])
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
  end

  def destroy
  end

  private

  def set_vendor
    @vendor = current_vendor.vendor
  end

  def category_params
    params.require(:food_category).permit(:title)
  end
end
