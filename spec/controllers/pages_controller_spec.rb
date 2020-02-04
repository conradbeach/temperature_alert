# frozen_string_literal: true

require "rails_helper"

RSpec.describe PagesController, type: :request do
  describe "#home" do
    it "returns a success response" do
      get root_path

      expect(response).to be_successful
    end

    it "displays the home page" do
      get root_path

      expect(response.body).to include("Welcome to Temperature Alert")
    end
  end
end
