require 'spec_helper'

describe VerifiedUser do
  describe "standard methods" do
    it "should create a new record with valid attributes" do
      lambda {
        Factory(:user)
      }.should change(VerifiedUser, :count).by(1)
    end
  end

  describe "validations" do
    describe "user_name" do
      it "should have user name greater than or equal to 4 characters" do
        user = Factory.build(:user, :user_name => "abc")
        user.should_not be_valid
      end

      it "should have user name less than or equal to 14 characters" do
        user = Factory.build(:user, :user_name => "a"*15)
        user.should_not be_valid
      end

      it "should not allow special characters" do
        user = Factory.build(:user, :user_name => "abcd*()")
        user.should_not be_valid
      end
    end
  end

  describe "craigskit email address" do
    it "should return the craigskit email address" do
      user = Factory(:user, :user_name => 'test')
      user.craigskit_email_address.should == "test@test.craigskit.com"
    end
  end

  describe "after create" do
    before do
      @user = Factory(:user)
    end

    describe "create_alias" do
      it "should be called" do
        stub.any_instance_of(VerifiedUser).create_alias
      end

      it "should create an alias" do
        stub(Alias).create!(:user => @user, :name => @user.user_name)
      end
    end

    describe "send welcome email" do
      it "should be called" do
        stub.any_instance_of(VerifiedUser).send_welcome_email
      end

      it "should send email" do
        stub(EmailMailer).welcome_email(@user)
      end

      it "should send new user notification email" do
        stub(EmailMailer).support_email(@user.email, @user.aliases.first.name,  "New Crowd Spot User!", "I am new!")
      end
    end
  end
end