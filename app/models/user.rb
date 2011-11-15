class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :spots, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :reservation_attempts, :dependent => :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :facebook_id

  def self.find_or_create_by_email(email)
    (user = User.find_by_email(email)) ? user : User.create!(:email => email, :password => 'password')
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']

    if user = User.find_by_email(data["email"])
      if (facebook_id = data["id"]) != user.facebook_id
        user.update_attribute(:facebook_id, facebook_id)
      end
      user
    else
      nil
    end
  end
end
