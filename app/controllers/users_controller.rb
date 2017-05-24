class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
    authorize @user
  end

  def edit
    @user = User.find_by(username: params[:username])
    authorize @user
  end

  def update
    @user = User.find_by(username: params[:username])
    authorize @user
    if @user.update_attributes(user_update_params)
      flash[:success] = 'Profile updated'
      redirect_to users_show_path(username: @user.username)
    else
      render 'edit'
    end
  end

  private

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end
end
