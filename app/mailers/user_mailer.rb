class UserMailer < ApplicationMailer
  def changed_password_email(email_address)
    @email_address = email_address
    @user = email_address.user
    mail to: email_address.email_address, subject: 'Floworx SysArch - Password Changed'
  end

  def password_reset_email(user)
    @user = user
    @email_address = user.primary_email
    mail to: @email_address.email_address, subject: 'Floworx SysArch - Reset Password'
  end

  def password_reset_successful_email(user)
    @user = user
    @email_address = user.primary_email
    mail to: @email_address.email_address, subject: 'Floworx SysArch - Password has been reset'
  end
end
