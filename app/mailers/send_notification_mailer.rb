class SendNotificationMailer < ApplicationMailer
  def notification(email, title)
    @title = title
    mail(to: email, subject: 'Event details')
  end
end