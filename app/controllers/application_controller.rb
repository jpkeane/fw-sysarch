class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :logged_in_user

  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized
    flash[:danger] = 'You do not have the authorization to do that'
    redirect_to root_url
  end
end
