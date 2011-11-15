class StaticController < ApplicationController
  skip_before_filter :authenticate_verified_user!

  PAGES = %w{pricing features legal support contact privacy get_started}

  PAGES.each do |page|
    define_method(page) {}
  end

  def send_support_email
    if EmailMailer.support_email(params[:email], params[:author], params[:subject], params[:message]).deliver
      respond_to do |format|
        format.js { render :text=> "<div class='success'></div>" }
      end
    else
      respond_to do |format|
        format.js { render :text=> "<div class='failure'></div>" }
      end
    end
  end
end
