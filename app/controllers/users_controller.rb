class UsersController < ApplicationController
  def create
    user = User.new(permitted_params)

    if user.save
      sign_in(:user, user)

      redirect_to :back
    else
      redirect_to :back, error: user.errors.full_messages.join("\n")
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
