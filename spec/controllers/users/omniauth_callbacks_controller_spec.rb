require 'spec_helper'

describe VerifiedUsers::OmniauthCallbacksController do
  include Devise::TestHelpers

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]

  end

  describe "facebook" do
    before do
      @email = "any@one.com"
    end

    it "should sign in and redirect existing user" do
      env = {"omniauth.auth" => {'extra' => {'user_hash' => {'email' => @email}}}}
      stub(@controller).env { env }
      @user = Factory(:user, :email => @email)
      get :facebook
      response.should redirect_to root_url
    end

    it "should redirect to registration for new user" do
      env = {"omniauth.auth" => {'extra' => {'user_hash' => {'email' => @email}}}}
      stub(@controller).env { env }
      get :facebook
      response.should redirect_to new_user_registration_url
    end
  end

  describe "create_user" do
    describe "sunny day" do
      before do
        mock(SignedRequest).parse(anything) { {:registration => {:email => "any@one.com",
                                                                 :name => "Any One",
                                                                 :user_name => "anyone",
                                                                 :password => "anypassword",
                                                                 :user_id => 1234567890}} }
      end

      it "should create a user" do
        lambda {
          get :facebook_create_user
        }.should change(VerifiedUser, :count).by(1)
      end

      it "should redirect the user to the root" do
        post :facebook_create_user
        response.should redirect_to root_path
      end
    end

    describe "rainy day" do
      before do
        mock(SignedRequest).parse(anything) { raise Exception }
      end

      it "should populate flash message on error" do
        post :facebook_create_user
        flash[:alert].should_not be_blank
      end

      it "should redirect the user to the root on error" do
        post :facebook_create_user
        response.should redirect_to root_path
      end
    end
  end
end