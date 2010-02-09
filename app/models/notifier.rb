class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "MyPersonalFitness <noreply@vanhlebarsoftware.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
    content_type  "text/html"
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "MyPersonalFitness <noreply@vanhlebarsoftware.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
    content_type  "text/html"
  end
end
