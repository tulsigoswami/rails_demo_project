class UserMailer < ApplicationMailer
  default from: 'info.pranascore@gmail.com'

  def welcome_mail(user)
    @user = user

    mail(to: @user.email, subject: 'welcome here')
  end

  def password_token
    @user = params[:user]

    mail(to: @user.email, subject: 'Genrated token for your mail')
  end
end