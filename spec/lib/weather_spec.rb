# frozen_string_literal: true

require "rails_helper"

RSpec.describe Weather, type: :module do
  describe ".temperature_of" do
    before do
      WebMock.stub_request(:get, %r{https://api.darksky.net/forecast/\w+/18.180555,-66.749961})
        .to_return(
          status: 200,
          body: File.read(
            File.join("spec", "fixtures", "dark_sky_puerto_rico_response.json"),
          ),
        )
    end

    it "returns the current temperature of the given zip code" do
      expect(described_class.temperature_of("00601")).to eq(77)
    end

    context "when the given zip code isn't in the data set" do
      it "raises an exception" do
        expect do
          described_class.temperature_of("00000")
        end.to raise_error(Weather::UnrecognizedZipCode, /couldn't find latitude and longitude/)
      end
    end

    context "when the given zip code is nil" do
      it "raises an exception" do
        expect do
          described_class.temperature_of(nil)
        end.to raise_error(Weather::UnrecognizedZipCode, /couldn't find latitude and longitude/)
      end
    end
  end
end
