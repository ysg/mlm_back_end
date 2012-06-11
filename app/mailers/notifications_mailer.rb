class NotificationsMailer < ActionMailer::Base

  default :from => 'info@blackpridebeauty.com',
         :return_path => 'info@blackpridebeauty.com',
         :to => 'deborahglass77@gmail.com'

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end