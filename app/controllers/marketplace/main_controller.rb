class Marketplace::MainController < ApplicationController
  layout "marketplace"

  private

  def set_vendor
    @vendor = Vendor::Vendor.find_by(city: params[:city])
  end

  def chit_id
    if set_vendor
      "chit_id_for_#{ params[:city] }"
    end
  end

  def set_chit
    @ordering_chit ||= if session[chit_id]
      @vendor.order_chits.find_by(id: session[key]) || @vendor.order_chits.new
    else
      @vendor.order_chits.new
    end

    session[key]

    return @ordering_chit
  end

  def chit_item_count
    set_chit.items.count
  end

  def raise_not_found(e)
    render template: "layouts/marketplace/not_found"
    Raygun.track_exception(e)
  end

end
