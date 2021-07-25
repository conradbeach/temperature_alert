# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alert, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  let!(:sns_client_double) { instance_double(Aws::SNS::Client) }

  before do
    allow(Aws::SNS::Client).to receive(:new).and_return(sns_client_double)
    allow(sns_client_double).to receive(:publish)

    travel_to(Time.current.change(hour: 10))
  end

  describe "#conditionally_deliver" do
    let!(:alert) { create(:alert) }

    context "when conditions are met" do
      it "delivers the alert" do
        alert.conditionally_deliver(alert.temperature_threshold + 5)

        expect(sns_client_double).to have_received(:publish)
          .with(
            phone_number: alert.user.phone_number,
            message: /Temperature Alert/,
          )
      end

      it "creates a new Delivery record" do
        expect do
          alert.conditionally_deliver(alert.temperature_threshold + 5)
        end.to change { alert.deliveries.size }.from(0).to(1)
      end

      it "gives the Delivery the correct sent_at time" do
        alert.conditionally_deliver(alert.temperature_threshold + 5)

        expect(alert.deliveries.last.sent_at).to be_within(5).of(Time.current)
      end
    end

    context "when the current temperature equals the temperature_threshold" do
      it "delivers the alert" do
        alert.conditionally_deliver(alert.temperature_threshold)

        expect(sns_client_double).to have_received(:publish)
          .with(
            phone_number: alert.user.phone_number,
            message: /Temperature Alert/,
          )
      end
    end

    context "when the alert has a custom message" do
      let(:custom_message) { "Extra info..." }
      let!(:alert) { create(:alert, message: custom_message) }

      it "includes the custom message in the message sent to the user" do
        alert.conditionally_deliver(alert.temperature_threshold + 5)

        expect(sns_client_double).to have_received(:publish)
          .with(
            phone_number: alert.user.phone_number,
            message: /#{custom_message}/,
          )
      end
    end

    context "when the current time is before 6am" do
      it "does not deliver the alert" do
        travel_to(Time.current.change(hour: 5, minute: 50))

        alert.conditionally_deliver(alert.temperature_threshold + 5)

        expect(sns_client_double).to_not have_received(:publish)
      end
    end

    context "when the current temperature is lower than the temperature threshold" do
      it "does not deliver the alert" do
        alert.conditionally_deliver(alert.temperature_threshold - 5)

        expect(sns_client_double).to_not have_received(:publish)
      end
    end

    context "when the alert has already been delivered today" do
      it "does not deliver the alert" do
        create(:delivery, alert: alert, sent_at: Time.current)

        alert.conditionally_deliver(alert.temperature_threshold + 5)

        expect(sns_client_double).to_not have_received(:publish)
      end
    end
  end
end
