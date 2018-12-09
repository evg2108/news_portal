class EventsController < ApplicationController
  helper_method :filter, :user_filters

  after_action :update_last_notified_event_id, only: [:show, :new_events]

  def index
    @events = filter.search_events.eager_load(:topics).page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @last_notified_event_id = @event.id

    render json: { title: @event.title }
  end

  def new_events
    @events = Filter.search_all_new_events(current_user)
    @last_notified_event_id = @events.sort_by(&:id).last.id if @events.any?

    render json: { events: @events.map(&:title) }
  end

  private

  def filter
    @filter ||= Filter.new(permitted_filter_params)
  end

  def user_filters
    current_user.filters
  end

  def permitted_filter_params
    params.fetch(:filter, {}).permit(:city_id, :tag_id, :begin_interval, :end_interval)
  end

  def update_last_notified_event_id
    return unless @last_notified_event_id

    current_user.update last_notified_event_id: @last_notified_event_id
  end
end
