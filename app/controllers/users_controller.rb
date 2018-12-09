class UsersController < ApplicationController
  def create
    user = User.new(permitted_params)

    if user.save
      sign_in(:user, user)

      respond_to do |format|
        # format.html { redirect_to :back }
        format.json { render json: {}, location: request.env['HTTP_REFERER'] || '/', status: :created }
      end
    else
      respond_to do |format|
        # format.html { redirect_to :back, error: user.errors.full_messages.join("\n") }
        format.json { render json: { error: user.errors.full_messages.join('<br>') }, status: :bad_request }
      end
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
