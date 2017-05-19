class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :logged_in_user

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = 'You are not logged in'
    redirect_to login_url
  end

  def guest_user_only
    return unless logged_in?
    flash[:info] = 'You are already logged in'
    redirect_to root_url
  end
end
