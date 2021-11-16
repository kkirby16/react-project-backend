# class ApplicationController < ActionController::API
#   include ::ActionController::Cookies #also need to tell our controllers that we turned this stuff on.

#   def current_user
#     @current_user ||= User.find_by(id: session[:user_id])
#     #adding mocked version of being logged in.
#   end

#   def logged_in?
#     !!current_user
#   end
# end

class ApplicationController < ActionController::API
  before_action :authenticate_user
  include ::ActionController::Cookies #also need to tell our controllers that we turned this stuff on.

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #adding mocked version of being logged in.
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user
    head :unauthorized if !current_user
  end
end
