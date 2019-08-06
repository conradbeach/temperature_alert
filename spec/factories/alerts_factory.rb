# frozen_string_literal: true

FactoryBot.define do
  factory :alert do
    temperature_threshold { (50..100).to_a.sample }

    user
  end
end
