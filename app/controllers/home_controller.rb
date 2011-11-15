class HomeController < ApplicationController
  skip_before_filter :authenticate_verified_user!, :only => [:index]

  def index
    if verified_user_signed_in?
      @spots = Spot.all
      render
    else
      render :layout => "landing_page", :template => 'static/homepage'
    end
  end
end