class Marketplace::CityController < Marketplace::MainController
  def show
    redirect_to city_menus_path(params[:city])
  end
end
