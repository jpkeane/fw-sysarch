class RegistrationMailer < ApplicationMailer
  def welcome_email(email_address)
    @email_address = email_address
    @user = email_address.user
    mail to: email_address.email_address, subject: 'Welcome to Floworx'
  end
end
