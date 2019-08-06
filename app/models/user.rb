# frozen_string_literal: true

# Represents an end user of the application.
class User < ApplicationRecord
  include Clearance::User

  has_many :alerts, dependent: :destroy
end
