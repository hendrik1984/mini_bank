class UsersController < ApplicationController
  # before_action :require_login, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.balance ||= 0
    
    if @user.save
      # session[:user_id] = @user.id
      redirect_to login_path, notice: "Account created!, Please try to login"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role)
  end

end
