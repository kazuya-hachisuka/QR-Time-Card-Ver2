class LocalesController < ApplicationController

  def index
    @locale = Locale.all
  end

  def new
    @locale = Locale.new
  end

  def create
    Locale.create(locale_params)
    binding.pry
  end

  private

  def locale_params
    params.require(:locale).permit(:locale_name,:admin_id)
  end

  def admin_params
    params.require(:admin).permit(:id)
  end
end
