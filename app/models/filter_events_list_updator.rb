class FilterEventsListUpdator
  attr_reader :filter

  def initialize(filter_id)
    @filter = Filter.find(filter_id)
  end

  def filter_params
    filter_params_presenter.for_query
  end

  private

  def filter_params_presenter
    @filter_params_presenter ||= FilterParamsPresenter.new(filter)
  end
end