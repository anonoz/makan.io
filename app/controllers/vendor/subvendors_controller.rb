class Vendor::SubvendorsController < Vendor::MainController
  before_action :set_subvendor, only: [:show, :edit, :update, :destroy]

  def index
    @subvendors = @vendor.subvendors
    @new_subvendor = Vendor::Subvendor.new
  end

  def show
  end

  def new
  end

  def create
    @subvendor= @vendor.subvendors.new(subvendor_params)

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
  end

  def destroy
  end

  private

  def set_subvendor
    @subvendor = @vendor.subvendors.find_by_id(params[:id])
  end

  def subvendor_params
    params.require(:vendor_subvendor).permit(:title)
  end
end