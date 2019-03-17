class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    creator = PostCreator.new(current_user, params[:topic_id])
    creator.create!(permitted_params)

    redirect_to topic_path(creator.topic)
  end

  private

  def permitted_params
    params.require(:post).permit(:message)
  end
end
