# frozen_string_literal: true

Clearance.configure do |config|
  config.cookie_domain = "temperature-alert.herokuapp.com"
  config.mailer_sender = "help@temperature-alert.herokuapp.com"
  config.redirect_url = "/dashboard"
  config.rotate_csrf_on_sign_in = true
  config.secure_cookie = true
  config.user_model = "User"
end
