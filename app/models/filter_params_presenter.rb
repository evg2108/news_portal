class FilterParamsPresenter
  attr_reader :filter

  def initialize(filter)
    @filter = filter
  end

  def for_query
    { filter: filter.attributes.slice('city_id', 'tag_id', 'begin_interval', 'end_interval') }
  end
end