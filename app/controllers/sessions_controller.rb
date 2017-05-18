class SessionsController < ApplicationController
  skip_before_action  :logged_in_user,  only: %i[new create]
  before_action       :guest_user_only, only: %i[new create]

  def new; end

  def create
    session = params[:session]

    user = User.find_by(username: session[:username].downcase)
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

  private

  def successful_sign_in(user)
    log_in user
    remember(user) if params[:session][:remember_me] == '1'
    flash[:success] = 'Log in successful'
    redirect_to user
  end

  def unsuccessful_sign_in
    flash.now[:danger] = 'Invalid username or password'
    render 'new'
  end
end
