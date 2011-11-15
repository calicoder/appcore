require "spec_helper"

describe EmailMailer do
  before do
    @user = Factory(:user)
    @another_user = Factory(:user)
    @default_from = "noreply@craigskit.com"
    @subject = "You have a message!"
    @body_plain = "This is your plain message"
    @body_html = "This is your html message"
  end

  describe "#forward_email" do
    it "should been delivered" do
      @email = EmailMailer.forward_email(@user, @subject, @body_plain, @body_html).deliver
      ActionMailer::Base.deliveries.empty?.should be_false
    end

    describe "multipart" do
      its "should be correct" do
        @email = EmailMailer.forward_email(@user, @subject, @body_plain, @body_html).deliver
        @email.multipart?.should == true
        @email.to.should == [@user.email]
        @email.from.should == [@default_from]
        @email.subject.should == @subject
        @email.encoded.should =~ /#{@body_plain}/
        @email.encoded.should =~ /#{@body_html}/
      end
    end

    describe "singlepart" do
      its "should be correct" do
        @email = EmailMailer.forward_email(@user, @subject, @body_plain, "").deliver
        @email.multipart?.should == false
        @email.to.should == [@user.email]
        @email.from.should == [@default_from]
        @email.subject.should == @subject
        @email.encoded.should =~ /#{@body_plain}/
        @email.encoded.should_not =~ /#{@body_html}/
      end
    end
  end

  describe "#convo messaging email" do
    before do
      @from = "alias123@calicoder.craigskit.com"
      @to = @user.email
    end

    describe "#to buyer" do
      before do
        @email = EmailMailer.convo_messaging_email_to_buyer(@from, @user, @subject, @body_plain).deliver
      end

      it "should been delivered" do
        ActionMailer::Base.deliveries.empty?.should be_false
      end

      its "should be correct" do
        @email.to.should == [@to]
        @email.from.should == [@from]
        @email.subject.should == @subject
        @email.encoded.should =~ /#{@body_plain}/
      end
    end

    describe "#to seller" do
      before do
        @email = EmailMailer.convo_messaging_email_to_seller(@from, @user, @another_user, @subject, @body_plain).deliver
      end

      it "should been delivered and correct" do
        ActionMailer::Base.deliveries.empty?.should be_false
      end

      its "should be correct" do
        @email.to.should == [@to]
        @email.from.should == [@from]
        @email.subject.should == @subject
        @email.encoded.should =~ /#{@body_plain}/
      end
    end
  end

  describe "convo_messaging_error_email" do
    before do
      @email = EmailMailer.convo_messaging_error_email(@user.email, @subject, @body_plain).deliver
    end

    it "should send email" do
      ActionMailer::Base.deliveries.empty?.should be_false
    end

    it "should be correct" do
      @email.to.should == [@user.email]
      @email.from.should == [@default_from]
      @email.subject.should =~ /#{@subject}/
      @email.encoded.should =~ /#{@body_plain}/
    end
  end

  describe "support_email" do
    before do
      @name = "Joe Smoe"
      @email = EmailMailer.support_email(@user.email, @name, @subject, @body_plain).deliver
    end

    it "should send email" do
      ActionMailer::Base.deliveries.empty?.should be_false
    end

    it "should be correct" do
      @email.to.should == ["support@craigskit.com"]
      @email.from.should == [@default_from]
      @email.subject.should =~ /#{@subject}/
      @email.encoded.should =~ /#{@body_plain}/
    end
  end

  describe "welcome_email" do
    before do
      @email = EmailMailer.welcome_email(@user).deliver
    end

    it "should send email" do
      ActionMailer::Base.deliveries.empty?.should be_false
    end

    it "should be correct" do
      @email.to.should == [@user.email]
      @email.from.should == [@default_from]
      @email.subject.should =~ /Welcome to Crowd Spot/
    end
  end

  describe "Exceptomail" do
    it "should deliver" do
      EmailMailer.exception_mail(Exception.new("Some Exception"), "Some message", "Some custom message").deliver
      ActionMailer::Base.deliveries.empty?.should be_false
    end
  end
end
