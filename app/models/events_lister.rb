class EventsLister
  attr_reader :filter

  def initialize(filter_params)
    @filter = Filter.new(filter_params)
  end

  def events
    @events ||= events_filter_applier.apply_filter
  end

  private

  def events_filter_applier
    @filter_applier ||= EventsFilterApplier.new(filter)
  end
end