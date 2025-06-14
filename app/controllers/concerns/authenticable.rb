module Authenticable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      current_user.present?
    end

    def redirect_if_logged_in
      redirect_to votes_path if logged_in?
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:alert] = "You must be logged in to access this page"
        redirect_to root_path
      end
    end
  end
end