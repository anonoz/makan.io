class Vendor::MainController < ApplicationController
  layout "vendor"

  before_action :authenticate_vendor!

  def index
    @vendor = current_vendor.vendor.title
  end
end
