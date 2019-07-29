# frozen_string_literal: true

# Represents the delivery of an alert to a user. As of now, alerts are
# only sent via SMS.
class Delivery < ApplicationRecord
  belongs_to :alert
end
