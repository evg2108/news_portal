class EventsFilterApplier
  attr_reader :filter, :filtered_events

  def initialize(filter)
    @filter = filter
  end

  def apply_filter
    init_query

    filter_by_city
    filter_by_tag
    filter_by_event_beginning_interval

    filtered_events
  end

  private

  def filter_by_event_beginning_interval
    if filter.begin_interval
      @filtered_events = filtered_events.where(Event.arel_table[:begin_time].gteq(filter.begin_interval))
    end

    if filter.end_interval
      @filtered_events = filtered_events.where(Event.arel_table[:begin_time].lteq(filter.end_interval))
    end
  end

  def filter_by_tag
    return unless filter.tag_id

    @filtered_events = filtered_events.joins(:tags).where(tags: {id: filter.tag_id})
  end

  def init_query
    @filtered_events = Event.order(created_at: :desc)
  end

  def filter_by_city
    return unless filter.city_id

    @filtered_events = filtered_events.joins(place: :city).where(places: { city_id: filter.city_id })
  end
end