require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BrownfieldOfDreams
  class Application < Rails::Application
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { :authentication => :plain,
                                           :address => "smtp.mailgun.org",
                                           :port => 587,
                                           :domain => ENV['mailgun_domain'],
                                           :user_name => ENV['mailgun_username'],
                                           :password => ENV['mailgun_password']
                                         }


  end
end
