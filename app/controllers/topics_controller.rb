class TopicsController < ApplicationController
  def show
    @topic = Topic.eager_load(posts: :user).find(params[:id])
    @event = @topic.event
    @posts = @topic.posts.order(created_at: :desc).page(params[:page])
  end
end
