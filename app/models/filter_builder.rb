class FilterBuilder
  attr_reader :user, :filter_params

  def self.build_filter(user, filter_params)
    instance = new(user, filter_params)
    instance.build
  end

  def initialize(user, filter_params)
    @user = user
    @filter_params = filter_params
  end

  def build
    user.filters.build(normalized_params)
  end

  def normalized_params
    result = filter_params.select{ |k, v| v.present? }
    result[:name] ||= "Filter##{Time.now.to_f}"
    result
  end
end