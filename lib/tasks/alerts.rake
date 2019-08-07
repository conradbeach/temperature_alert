# frozen_string_literal: true

namespace :alerts do
  desc "Conditionally delivers alerts via SMS. This task is called by Heroku scheduler."
  task deliver: :environment do
    User.deliver_alerts
  end
end
