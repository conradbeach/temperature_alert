# frozen_string_literal: true

# Represents an alert created by an individual User.
# When the temperature in a User's area hits the temperature stored in the
# Alert, a notification is sent to the User. This notification will include the
# Alert's message if one is given.
class Alert < ApplicationRecord
  belongs_to :user
  has_many :deliveries
  validates :temperature_threshold, presence: true
end
