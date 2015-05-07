class UserEmailer < ApplicationMailer
  default from: 'laurawhalin@gmail.com'

  def send_welcome_email(user, password)
    @user = user
    @password = password
    mail( to: @user.email,
          subject: 'Thanks for signing up for TechHire!'
          )
  end
end
