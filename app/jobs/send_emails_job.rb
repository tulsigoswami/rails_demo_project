class SendEmailsJob < ApplicationJob
  queue_as :default

  before_perform { |job| puts job.arguments }
  def perform(user)
    UserMailer.welcome_mail(user).deliver
  end
end
