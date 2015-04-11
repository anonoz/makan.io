class Vendor::MainController < ApplicationController
  layout "vendor"
  before_action :authenticate_vendor!, :set_vendor

  def index
    @vendor = current_vendor.vendor.title
  end

  private

  def set_vendor
    @vendor = current_vendor.vendor
  end
end
