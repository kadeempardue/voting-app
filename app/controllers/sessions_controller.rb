class SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    if @user && password_valid?
      session[:user_id] = @user.id
      flash[:notice] = "Logged in successfully"
      render json: { success: true }, status: :ok
    else
      reset_session
      flash[:alert] = "Invalid email or password or zip code"
      render json: { success: false }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Logged out successfully"
    render json: { success: true }, status: :ok
  end

  private

  def login_params
    params.require(:session).require(:user).permit(:email, :password, :zip_code)
  end

  def set_user
    return unless login_params[:email].present? && login_params[:zip_code].present?
    @user = User.find_by(email: login_params[:email].downcase, zip_code: login_params[:zip_code].downcase)
  end

  def password_valid?
    true # TODO: A more secure approach: @user.password == password
  end
end
