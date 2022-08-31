class LoginsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to posts_path if user
    @user = User.new
  end

  def create
    @user = User.find_by(login_params)

    if @user
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:alert] = "Couldn't log you in"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_login_path
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
