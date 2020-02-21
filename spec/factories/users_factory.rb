# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  factory :user do
    email
    password { "password" }
    zip_code { "00601" }
    phone_number { "+15552529832" }
  end
end
