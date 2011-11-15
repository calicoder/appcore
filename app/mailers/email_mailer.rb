class EmailMailer < ActionMailer::Base
  default :from => "Crowd Spot <noreply@crowdspot.com>"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Crowd Spot, #{@user.user_name}") do |format|
      format.text
      format.html
    end
  end

  def support_email(from_email, name, subject, message)
    @message = (message ? message : "")
    @name = (name ? name : "")
    @from_email = (from_email ? from_email : "")

    mail(:to => "support@craigskit.com", :subject => "Crowd Spot Contact Form: #{subject}") do |format|
      format.text { render :text => @name + " <" + @from_email + "> said: " + message }
    end
  end

  def exception_mail(exception, subject, custom_message)
    @to = "andrewkshin@gmail.com"
    @subject = "CK EXCEPTOMAIL: #{subject}"
    @exception = exception
    @custom_message = custom_message
    mail(:to => @to, :subject => @subject)
  end
end
