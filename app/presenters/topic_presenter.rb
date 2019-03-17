class TopicPresenter < SimpleDelegator
  attr_reader :page

  def initialize(obj, page)
    @page = page
    super(obj)
  end

  def paginated_posts
    @posts ||= posts.eager_load(:user).order(created_at: :desc).page(page)
  end
end