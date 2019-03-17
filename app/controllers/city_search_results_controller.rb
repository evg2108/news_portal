class CitySearchResultsController < ApplicationController
  def index
    result = City.identified_search(params[:query], :name)
    render json: result
  end
end