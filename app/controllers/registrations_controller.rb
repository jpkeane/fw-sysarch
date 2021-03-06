class RegistrationsController < ApplicationController
  skip_before_action :logged_in_user,  only: %i[new create]
  before_action      :guest_user_only, only: %i[new create]
  skip_after_action  :verify_authorized

  def new
    @user = User.new
    @user.email_addresses.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      RegistrationMailer.welcome_email(@user.primary_email).deliver_later
      flash[:info] = 'Account created successfully'
      log_in @user
      redirect_to dashboard_url
    else
      flash.now[:warning] = 'There was a problem with your registration'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :location, :password, :password_confirmation,
                                 email_addresses_attributes: :email_address)
  end
end
