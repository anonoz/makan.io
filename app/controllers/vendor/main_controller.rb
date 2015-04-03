class Vendor::MainController < ApplicationController
  def index
    unless vendor_signed_in?
      redirect_to new_vendor_session_path
    end
  end
end
