require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:items) }
    it { should have_many(:aliases) }
    it { should have_many(:convo_messagings) }
  end

  describe "methods" do
    before do
      @email = "a#{rand(100000)}@b.com"
    end

    describe "class methods" do
      describe "#find_or_create_by_email" do
        it "should find user by email if present" do
          @user = Factory(:user, :email => @email)
          User.find_or_create_by_email(@email).should == @user
        end

        it "should find email_user by email if present" do
          @user = Factory(:email_user, :email => @email)
          User.find_or_create_by_email(@email).should == @user
        end

        it "should create email_user if not present" do
          lambda {
            User.find_or_create_by_email(@email)
          }.should change(EmailUser, :count).by(1)
        end
      end

      describe "find_for_facebook_oauth" do
        before do
          @facebook_id = 1234
          @user = Factory(:user, :email => @email, :facebook_id => 1234)
        end

        describe "if email found" do
          it "should return user if email is found" do
            access_token = {'extra' => {'user_hash' => {'email' => @email}}}
            User.find_for_facebook_oauth(access_token).should == @user
          end

          it "should return user if facebook_id is different" do
            new_facebook_id = 4321
            access_token = {'extra' => {'user_hash' => {'email' => @email, 'id' => new_facebook_id}}}
            User.find_for_facebook_oauth(access_token).should == @user
          end

          it "should update facebook_id if facebook_id is different" do
            new_facebook_id = 4321
            access_token = {'extra' => {'user_hash' => {'email' => @email, 'id' => new_facebook_id}}}
            lambda {
              User.find_for_facebook_oauth(access_token)
              @user.reload
            }.should change(@user, :facebook_id).from(@facebook_id).to(new_facebook_id)
          end

          it "should return user if facebook_id is same" do
            access_token = {'extra' => {'user_hash' => {'email' => @email, 'id' => @facebook_id}}}
            User.find_for_facebook_oauth(access_token).should == @user
          end

          it "should not update facebook_id if facebook_id is same" do
            access_token = {'extra' => {'user_hash' => {'email' => @email, 'id' => @facebook_id}}}
            lambda {
              User.find_for_facebook_oauth(access_token)
            }.should_not change(@user, :facebook_id)
          end
        end

        describe "if email not found" do
          it "should return nil if email is not found" do
            access_token = {'extra' => {'user_hash' => {'email' => "somerandom@email.com"}}}
            User.find_for_facebook_oauth(access_token).should == nil
          end
        end
      end
    end
  end
end