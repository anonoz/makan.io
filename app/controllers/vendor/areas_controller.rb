class Vendor::AreasController < Vendor::MainController
  def index
    @cities = Place::City.includes(:areas)
  end

  def show
  end

  def new
  end

  def create
    @area = Place::Area.new(area_params)

    if @area.save
      redirect_to vendor_areas_path,
                  flash: {success: "Area #{ @area.name } created."}
    else
      redirect_to vendor_areas_path,
                  flash: {error: @area.errors.full_messages.to_sentence}
    end
  end

  def edit
  end

  def update
  end

  def destroy
  	if @area.destroy
  	  redirect_to vendor_areas_path,
  	              flash: {success: "Area #{ @area.name } destroyed."}
  	else
  	  redirect_to vendor_areas_path,
  	              flash: {error: "Cannot Delete #{ @area.name }"}
  	end
  end

  private

  def set_area
    @area = Place::Area.find_by_id params[:id]
  end

  def area_params
    params.require(:place_area).permit(:name, :place_city_id)
  end

end
