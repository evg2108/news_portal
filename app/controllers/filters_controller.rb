class FiltersController < ApplicationController
  before_action :authenticate_user!

  def destroy
    filter = Filter.find(params[:id])
    filter.destroy

    redirect_to request.env['HTTP_REFERER']
  end
end
