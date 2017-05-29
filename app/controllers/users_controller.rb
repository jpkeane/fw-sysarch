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

  def change_password
    @user = User.find_by(username: params[:username])
    authorize @user
  end

  def update_password
    @user = User.find_by(username: params[:username])
    authorize @user
    if @user.authenticate(params[:user][:current_password])
      correct_user_password_change
    else
      @user.errors.add(:current_password, 'is incorrect')
      render 'change_password'
    end
  end

  private

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end

  def user_update_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def correct_user_password_change
    if params[:user][:password].blank?
      @user.errors.add(:password, 'must be entered')
      render 'change_password'
    elsif @user.update_attributes(user_update_password_params)
      UserMailer.changed_password_email(@user.primary_email).deliver_later
      flash[:success] = 'Password changed'
      redirect_to users_show_path(username: @user.username)
    else
      render 'change_password'
    end
  end
end
