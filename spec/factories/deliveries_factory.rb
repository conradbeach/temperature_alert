# frozen_string_literal: true

FactoryBot.define do
  factory :delivery do
    sent_at { Time.current }

    alert
  end
end
