class UserMailer < ApplicationMailer
  default from:'info.pranascore@gmail.com'

  def welcome_mail
    @user= params[:user]

    mail(to:@user.email, subject:'welcome here')
  end
end
