class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = 'Account created successfully'
      redirect_to root_url
    else
      flash.now[:warning] = 'There was a problem with your registration'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
  end
end
