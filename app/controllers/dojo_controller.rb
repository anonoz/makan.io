class DojoController < ApplicationController
  skip_before_action :verify_authenticity_token

  def main
    render json: params
  end
end
