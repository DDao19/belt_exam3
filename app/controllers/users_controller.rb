class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :auth, only: [:show]

  def index
    @user = User.find(current_user)
    @organizations = Organization.all
  end

  def new

  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      return redirect_to groups_path
    end

    flash[:errors] = user.errors.full_messages
    return redirect_to "/"
  end

  def show
    @user = User.find(current_user)
    @organization = Organization.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def auth
    user_id = params[:id].to_i
    return redirect_to "/users/#{current_user.id}" unless current_user.id == user_id
  end
end
