class SessionsController < ApplicationController
  skip_before_action  :logged_in_user,  only: %i[new create]
  before_action       :guest_user_only, only: %i[new create]
  skip_after_action   :verify_authorized

  def new; end

  def create
    session = params[:session]
    user = user_to_sign_in(session[:username])

    if user && user.authenticate(session[:password])
      successful_sign_in(user)
    else
      unsuccessful_sign_in
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Log out successful'
    redirect_to root_url
  end

  def destroy_from_all
    log_out_all if logged_in?
    flash[:success] = 'Log out from all devices successful'
    redirect_to root_url
  end

  private

  def user_to_sign_in(credential)
    if /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i =~ credential
      EmailAddress.find_by(email_address: credential).user
    else
      User.find_by(username: credential.downcase)
    end
  end

  def successful_sign_in(user)
    log_in user
    remember(user) if params[:session][:remember_me] == '1'
    flash[:success] = 'Log in successful'
    redirect_to dashboard_url
  end

  def unsuccessful_sign_in
    flash.now[:danger] = 'Invalid username or password'
    render 'new'
  end
end
