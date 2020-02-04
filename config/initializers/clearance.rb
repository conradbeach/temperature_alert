# frozen_string_literal: true

Clearance.configure do |config|
  # Default configuration can be found [here](https://github.com/thoughtbot/clearance#configure).
  config.mailer_sender = "help@temperature-alert.herokuapp.com"
  config.redirect_url = "/dashboard"
  config.routes = false
end
