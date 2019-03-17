class TopicsController < ApplicationController
  def show
    @topic_presenter = TopicPresenter.new(Topic.find(params[:id]), params[:page])
  end
end
