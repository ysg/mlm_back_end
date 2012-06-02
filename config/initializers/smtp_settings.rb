ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :user_name => "rails.smtp.user",
    :password => 'rrrrrrrr123',
    :authentication => "plain",
    :enable_starttls_auto => true
}

