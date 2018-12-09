class FiltersController < ApplicationController
  before_action :authenticate_user!

  def create
    @filter = Filter.new(permitted_params)
    @filter.user_id = current_user.id

    if @filter.save
      respond_to do |format|
        # format.html { redirect_to :back }
        format.json { render json: { name: @filter.name, id: @filter.id } }
      end
    else
      respond_to do |format|
        # format.html { redirect_to :back, error: user.errors.full_messages.join("\n") }
        format.json { render json: { error: @filter.errors.full_messages.join('<br>') }, status: :bad_request }
      end
    end
  end

  def show
    render json: found_filter.to_json
  end

  def destroy
    found_filter.destroy

    render json: { id: found_filter.id }
  end

  private

  def found_filter
    @filter ||= Filter.find(params[:id])
  end

  def permitted_params
    params.require(:filter).permit(:name, :city_id, :tag_id, :begin_interval, :end_interval).select{ |k, v| v.present? }
  end
end
