class UserMailer < ApplicationMailer
  default to:->{User.pluck(:email)},
  from: 'tulsig@shriffle.com'

  def welcome_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome here!!')
  end
end
