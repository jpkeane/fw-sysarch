class UserMailer < ApplicationMailer
  def changed_password_email(email_address)
    @email_address = email_address
    @user = email_address.user
    mail to: email_address.email_address, subject: 'Floworx SysArch - Password Changed'
  end
end
