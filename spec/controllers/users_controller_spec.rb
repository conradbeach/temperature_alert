# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :request do
  describe "#show" do
    context "when logged in" do
      it "returns a success response" do
        get dashboard_path(as: create(:user))

        expect(response).to be_successful
      end

      it "displays the dashboard page" do
        get dashboard_path(as: create(:user))

        expect(response.body).to include("This is your dashboard.")
      end
    end

    context "when not logged in" do
      it "returns a failure response" do
        get dashboard_path

        expect(response).to_not be_successful
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
