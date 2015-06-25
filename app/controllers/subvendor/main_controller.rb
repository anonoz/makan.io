class Subvendor::MainController < ApplicationController
  layout "subvendor"
  before_action :authenticate_subvendor!, :set_subvendor

  def index

  end

  private

  def user_for_paper_trail
    if subvendor_signed_in?
      "subvendor_#{ @current_subvendor.id } #{ @current_subvendor.title }"
    end
  end

  def set_subvendor
    @current_subvendor = current_subvendor
  end
end
