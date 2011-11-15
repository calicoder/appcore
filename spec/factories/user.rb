Factory.define :user do |user|
  user.sequence(:email) {|n| "email#{rand(9999999)}@example.com"}
  user.password 'password'
end

Factory.define :email_user, :parent => :user, :class => EmailUser  do |email_user|
end

Factory.define :verified_user, :parent => :user , :class => VerifiedUser do |verified_user|
  verified_user.sequence(:name) {|n| "John Doe#{rand(9999999)}"}
end