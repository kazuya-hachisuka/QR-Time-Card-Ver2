class LocalesController < ApplicationController
  def new
    @locale = Locale.new
  end

  def create
    binding.pry
  end

  private

  def locale_params
    params.require(:locale).permit(:locale_name)
  end
end
