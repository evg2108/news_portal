class CitiesController < ApplicationController
  def search
    result = City.identified_search(params[:query], :name)
    render json: result
  end
end
