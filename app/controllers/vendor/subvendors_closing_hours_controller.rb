class Vendor::SubvendorsClosingHoursController < Vendor::MainController

  def index
    @subvendors = @vendor.subvendors.includes(:special_closing_hours)
  end

  def show
  end

  def new
  end

  def create
    @closing_hour = Vendor::SpecialClosingHour.new closing_hour_params

    if @closing_hour.save
      redirect_to vendor_subvendor_closing_hours_path,
                  flash: { success: "Closing Hour saved." }
    else
      redirect_to vendor_subvendor_closing_hours_path,
                  flash: { error: @closing_hour.errors.full_messages.to_sentence }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_closing_hour
    @closing_hour = @vendor.special_closing_hours.find_by_id params[:id]
  end

  def closing_hour_params
    params.require(:vendor_special_closing_hour).permit(
      :vendor_subvendor_id, :start_at, :end_at)
  end

end
