class NewFilteredUserEventsSearcher
  attr_reader :user, :new_fitted_events

  delegate :filters, :last_notified_event_id, to: :user, prefix: true

  def initialize(user)
    @user = user
  end

  def search
    result = user_filters.flat_map do |filter|
      filter_applier = EventsFilterApplier.new(filter)
      filter_applier.apply_filter
      filter_applier.filtered_events.where(only_new_events).to_a
    end

    @new_fitted_events = result.uniq.sort_by(&:id)
  end

  def last_fitted_event
    new_fitted_events.last
  end

  private

  def only_new_events
    Event.arel_table[:id].gt(user_last_notified_event_id)
  end
end