AppCore::Application.routes.draw do
  devise_for :verified_users, :controllers => {:omniauth_callbacks => "verified_users/omniauth_callbacks"}

  devise_scope :user do
    match '/verified_users/auth/:provider' => 'verified_users/omniauth_callbacks#passthru'
    match '/verified_users/auth/facebook/create_user' => 'verified_users/omniauth_callbacks#facebook_create_user'
  end

  match 'pricing' => 'static#pricing', :as => :pricing
  match 'features' => 'static#features', :as => :features
  match 'legal' => 'static#legal', :as => :legal
  match 'privacy' => 'static#privacy', :as => :privacy
  match 'support' => 'static#support', :as => :support
  match 'contact' => 'static#contact', :as => :contact
  match 'get_started' => 'static#get_started', :as => :get_started
  match 'send_support_email' => 'static#send_support_email', :as => :send_support_email, :via => :post

  root :to => "home#index"
end
