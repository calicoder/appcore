class VerifiedUser < User
  after_create :send_welcome_email

  def send_welcome_email
    #EmailMailer.welcome_email(self).deliver!
    #EmailMailer.support_email(self.email, self.name, "New Crowdspot User!", "I am new!").deliver!
  end
end
