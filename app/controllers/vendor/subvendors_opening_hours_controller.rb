class Vendor::SubvendorsOpeningHoursController < Vendor::MainController
  before_action :set_opening_hours, only: [:show, :edit, :update, :destroy]

  def index
    @subvendors = @vendor.subvendors.includes(:weekly_opening_hours)
    @new_opening_hours = Vendor::WeeklyOpeningHour.new
  end

  def show

  end

  def new

  end

  def create
  	@opening_hour = Vendor::WeeklyOpeningHour.new(opening_hours_params)
    
    if @opening_hour.save
      redirect_to vendor_subvendors_opening_hours_path, 
                  flash: {success: "Opening Hours created."}
    else
      redirect_to vendor_subvendors_opening_hours_path, 
                  flash: {error: @opening_hour.errors.full_messages.to_sentence}
    end
  end

  def destroy
    if @opening_hour.destroy
      redirect_to vendor_subvendors_opening_hours_path, 
                  flash: {success: "Opening Hours deleted."}
    else
      redirect_to vendor_subvendors_opening_hours_path, 
                  flash: {error: "Cannot delete."}
    end
  end

  private

  def set_opening_hours
    @opening_hour = @vendor.weekly_opening_hours.
                             find_by_id(params[:id])
  end

  def opening_hours_params
    params.require(:vendor_weekly_opening_hour).permit(
      :wday, :start_at, :end_at, :vendor_subvendor_id)
  end

end
