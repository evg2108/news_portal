class EventsController < ApplicationController
  def index
    lister = EventsLister.new(permitted_filter_params)
    @events = lister.events.eager_load(:topics).page(params[:page])
    @filter = lister.filter
  end

  private

  def permitted_filter_params
    params.fetch(:filter, {}).permit(:city_id, :tag_id, :begin_interval, :end_interval)
  end
end
