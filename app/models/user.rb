# frozen_string_literal: true

# Represents an end user of the application.
class User < ApplicationRecord
  include Clearance::User

  has_many :alerts, dependent: :destroy

  # Conditionally delivers all alerts for all users.
  def self.deliver_alerts
    current_temperatures = distinct.pluck(:zip_code).map do |zip_code|
      [zip_code, Weather.temperature_of(zip_code)]
    end.to_h

    find_each do |user|
      user.deliver_alerts(current_temperatures[user.zip_code])
    end
  end

  # Conditionally delivers all alerts for the user.
  def deliver_alerts(current_temperature)
    alerts.each do |alert|
      alert.conditionally_deliver(current_temperature)
    end
  end
end
