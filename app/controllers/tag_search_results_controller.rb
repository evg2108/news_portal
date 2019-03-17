class TagSearchResultsController < ApplicationController
  def index
    result = Tag.identified_search(params[:query], :name)
    render json: result
  end
end
