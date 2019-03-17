class SuitableEventFiltersFinder
  attr_reader :event, :suitable_filters

  def initialize(event)
    @event = event
  end

  def find_filters
    filters = Filter.joins(:user)
                .where(User.arel_table[:last_notified_event_id].lt(event.id))
                .suitable_by_time(event.begin_time)
                .suitable_by_city(event.city_id)
    filters = filters.suitable_by_tag_ids(event.tags.ids) if event.tags.any?

    @suitable_filters = filters.uniq
  end
end