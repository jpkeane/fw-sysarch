class PasswordResetsController < ApplicationController
  skip_before_action :logged_in_user
  before_action      :guest_user_only
  skip_after_action  :verify_authorized

  def new; end

  def create
    @user = User.find_by(username: params[:password_reset][:username].downcase)
    if @user
      @user.create_password_reset_token
      UserMailer.password_reset_email(@user).deliver_now
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def enter_token
    @user = User.new
  end

  def submit_token
    @user = User.find_by(password_reset_token: params[:user][:password_reset_token])
    if @user
      flash.now[:info] = 'Token valid'
      render 'reset_password'
    else
      flash.now[:danger] = 'Token not found'
      @user = User.new
      render 'enter_token'
    end
  end

  def reset_password
    @user = User.find_by(password_reset_token: params[:password_reset_token])
    if params[:user][:password].blank?
      @user.errors.add(:password, 'must be entered')
      render 'reset_password'
    elsif @user.update_attributes(user_update_password_params)
      valid_password_change
    else
      render 'reset_password'
    end
  end

  private

  def valid_password_change
    UserMailer.password_reset_successful_email(@user).deliver_now
    flash[:success] = 'Password changed'
    redirect_to root_path
  end

  def user_update_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
