class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    return User.find(session[:user_id]) if session.key? 'user_id'
  end

  def require_login
    return redirect_to new_session_path unless current_user
  end

  helper_method :current_user

end
