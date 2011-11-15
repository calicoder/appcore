class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :authenticate_verified_user!

  protect_from_forgery
end
