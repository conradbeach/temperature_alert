# frozen_string_literal: true

require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Users" do
  get "/user" do
    example "Listing users" do
      value = 10

      expect(value).to be 10
    end
  end
end
