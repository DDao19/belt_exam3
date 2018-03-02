class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]


  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id

        return redirect_to groups_path
      end

      flash[:errors] = ['Invalid Password.']
    else
      flash[:errors] = ['Email does not exist.']
    end

    return redirect_to new_session_path
  end

  def destroy
    session.delete(:user_id) if current_user
    return redirect_to new_session_path
  end

end
