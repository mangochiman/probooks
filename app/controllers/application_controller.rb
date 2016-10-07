# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  skip_before_filter :verify_authenticity_token
  # Scrub sensitive parameters from your log
  before_filter :authenticate_user
  filter_parameter_logging :password
  def authenticate_user
    user = User.find(session[:user].user_id) rescue nil
    return true unless user.blank?
    access_denied
    return false
  end

  def access_denied
    redirect_to ("/login") and return
  end
end
