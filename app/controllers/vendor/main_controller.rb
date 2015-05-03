class Vendor::MainController < ApplicationController
  layout "vendor"
  before_action :authenticate_vendor!, :set_vendor

  def index
    @vendor_title = current_vendor.vendor.title
  end

  private

  def set_vendor
    @vendor = current_vendor.vendor
  end

  def user_for_paper_trail
    if vendor_signed_in?
      "vendor_#{ current_vendor.id } #{ current_vendor.email }"
    end
  end

end
