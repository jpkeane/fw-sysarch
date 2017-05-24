class FrontPagesController < ApplicationController
  skip_before_action :logged_in_user
  skip_after_action :verify_authorized

  def home; end

  def about; end
end
