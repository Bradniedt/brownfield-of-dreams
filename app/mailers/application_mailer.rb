class ApplicationMailer < ActionMailer::Base
  default from: ENV['mailgun_username']
  layout 'mailer'
end
