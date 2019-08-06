# frozen_string_literal: true

# Represents an alert created by an individual User.
# When the temperature in a User's area hits the temperature stored in the
# Alert, a notification is sent to the User. This notification will include the
# Alert's message if one is given.
class Alert < ApplicationRecord
  belongs_to :user
  has_many :deliveries, dependent: :destroy

  validates :temperature_threshold, presence: true

  # Delivers the alert via SMS to the owning user if the following 2 conditions are met:
  # 1. The given `current_temperature` is greater than or equal to the `temperature_threshold` for the alert.
  # 2. The alert hasn't already been delivered today.
  #
  # @param current_temperature The current temperature for the owning user's zip code.
  #
  # @return The newly created `Delivery` record if the alert is delivered; `nil` otherwise.
  def conditionally_deliver(current_temperature)
    return if current_temperature < temperature_threshold
    return if delivered_today?

    deliver
  end

  private

  def delivered_today?
    latest_sent_at_time = deliveries.order(sent_at: :desc).pick(:sent_at)

    latest_sent_at_time&.today?
  end

  def deliver
    Aws::SNS::Client.new.publish(
      phone_number: user.phone_number,
      message: formatted_message,
    )

    deliveries.create(sent_at: Time.current)
  end

  def formatted_message
    "Temperature Alert: It hit #{temperature_threshold} degrees. #{message}"
  end
end
