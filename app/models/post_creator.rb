class PostCreator
  attr_reader :user, :topic_id, :topic

  def initialize(user, topic_id)
    @user = user
    @topic_id = topic_id
    @topic = Topic.find(topic_id)
  end

  def create!(params)
    topic.posts.create!(params.merge(user_id: user.id))
  end
end