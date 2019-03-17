class FilterEventsListCreator
  attr_reader :user, :filter, :options

  def initialize(user, filter_params, options = {})
    @user = user
    @filter = FilterBuilder.build_filter(user, filter_params)
    @options = options.slice(:save)
  end

  def store!
    filter.save if save?
  end

  def save?
    options[:save] == '1'
  end

  def filter_params
    filter_params_presenter.for_query
  end

  private

  def filter_params_presenter
    @filter_params_presenter ||= FilterParamsPresenter.new(filter)
  end
end