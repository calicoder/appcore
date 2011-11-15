require 'spec_helper'

describe HomeController do
  describe "logged in" do
    before do
      @user = Factory(:user)
      sign_in @user
      get :index
    end
    it { should assign_to(:items) }
    it { should render_template :index }
    it { should respond_with(:success) }
    it { should route(:get, "/").to(:action => :index) }
    it { should render_with_layout(:application) }
  end

  describe "not logged in" do
    before do
      get :index
    end
    it { should render_template 'static/homepage' }
    it { should respond_with(:success) }
    it { should route(:get, "/").to(:action => :index) }
    it { should render_with_layout(:landing_page) }
  end
end
