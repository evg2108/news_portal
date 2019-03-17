class FilteredEventsListsController < ApplicationController
  before_action :authenticate_user!

  def create
    manager = FilterEventsListCreator.new(current_user, permitted_params, params)
    manager.store!

    redirect_to events_path(manager.filter_params)
  end

  def update
    filter_events_list = FilterEventsListUpdator.new(params[:id])

    redirect_to events_path(filter_events_list.filter_params)
  end

  private

  def permitted_params
    params.require(:filter).permit(:name, :city_id, :tag_id, :begin_interval, :end_interval)
  end
end