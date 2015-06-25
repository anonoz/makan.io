class Vendor::SubvendorsController < Vendor::MainController
  before_action :set_subvendor, only: [:show, :edit, :update, :destroy]

  def index
    @cities = Place::Area.city.values
    @subvendors = @vendor.subvendors.includes(:food_menus)
    @new_subvendor = Vendor::Subvendor.new
  end

  def show
    # Earning performance
    
  end

  def new
  end

  def create
    @subvendor = @vendor.subvendors.new(subvendor_params)

    if @subvendor.save
      redirect_to vendor_subvendors_path,
                  flash: {success: "Subvendor #{ @subvendor.title } created."}
    else
      redirect_to vendor_subvendors_path,
                  flash: {error: @subvendor.errors.full_messages.to_sentence}
    end
  end

  def edit
  end

  def update
    @subvendor.attributes = subvendor_params

    if @subvendor.save
      redirect_to vendor_subvendor_path(@subvendor),
                  flash: {success: "Subvendor #{ @subvendor.title } updated."}
    else
      render "edit", flash: {error: @subvendor.errors.full_messages.to_sentence}
    end
  end

  def destroy
    if @subvendor.destroy
      redirect_to vendor_subvendors_path,
                  flash: {success: "Subvendor #{ @subvendor.title } deleted."}
    else
      redirect_to vendor_subvendors_path,
                  flash: {error: @subvendor.errors.full_messages.to_sentence}
    end
  end

  private

  def set_subvendor
    @subvendor = @vendor.subvendors.find_by_id(params[:id])
  end

  def subvendor_params
    params.require(:vendor_subvendor).permit(:title, :city, :email, :password, :password_confirmation)
  end
end
