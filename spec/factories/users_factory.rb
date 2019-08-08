# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    zip_code { "00601" }
    phone_number { "+15552529832" }
  end
end
