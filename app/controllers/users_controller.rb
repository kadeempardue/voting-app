class UsersController < ApplicationController
  before_action :redirect_if_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # Login the user
      flash[:notice] = "Account created successfully"
      render json: { success: true }, status: :ok
    else
      flash[:alert] = "Invalid email or password or zip code"
      render json: { success: false }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :zip_code)
  end
end