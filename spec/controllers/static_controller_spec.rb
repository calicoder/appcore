require 'spec_helper'

describe StaticController do
  StaticController::PAGES.each do |page|
    describe "#{page}" do
      before do
        get page
      end
      it { should render_template page }
      it { should respond_with(:success) }
      it { should route(:get, "/#{page}").to(:action => page) }
      it { should render_with_layout(:application) }
    end
  end

  describe "send_support_email" do
    before do
      @author = "Joe Smoe"
      @email = "joe@smoe.com"
      @subject = "Awesome site"
      @message = "This is a great site!"
      xhr :post, :send_support_email, :author => @author, :email => @email, :subject => @subject, :message => @message
    end

    it "should return 200 success" do
      response.body.should =~ /class='success'/
      response.code.should == "200"
    end

    it "should send email" do
      #mock(EmailMailer).support_email(anything, anything, anything, anything)
      ActionMailer::Base.deliveries.empty?.should be_false
    end
  end
end
