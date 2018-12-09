class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @topic = Topic.find(params[:topic_id])

    @post = Post.new(permitted_params)
    @post.topic_id = @topic.id
    @post.user_id = current_user.id

    @post.save
    respond_to do |format|
      format.html { redirect_to topic_path(@topic) }
      format.json { render json: { success: true } }
    end
  end

  private

  def permitted_params
    params.require(:post).permit(:message)
  end
end
