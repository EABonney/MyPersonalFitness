require 'smtp-tls'

# Configuration items for ActionMailer
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
 :address => "mail.vanhlebarsoftware.com",
 :port => 25,
 :domain => "vanhlebarsoftware.com",
 :authentication => :plain,
 :user_name => "eric.bonney@vanhlebarsoftware.com",
 :password => "Tanis*1973",
 :enable_starttls_auto => true
}
ActionMailer::Base.raise_delivery_errors = true;
ActionMailer::Base.default_content_type = "text/html"
