class TagsController < ApplicationController
  def search
    result = Tag.identified_search(params[:query], :name)
    render json: result
  end
end
