# frozen_string_literal: true

module Weather
  BASE_API_URL = "https://api.darksky.net/forecast"

  # Returns the current temperature of the given zip code.
  #
  # @param zip_code [String] The zip code to fetch the temperature for.
  #
  # @return [Integer] The current temperature of the given zip code rounded to the nearest integer.
  def self.temperature_of(zip_code)
    lat_lng = zip_to_lat_lng(zip_code)

    raise UnrecognizedZipCode unless lat_lng

    fetch_temperature(lat_lng["lat"], lat_lng["lng"])
  end

  # private

  def self.zip_to_lat_lng(zip_code)
    @lat_lngs ||= YAML.safe_load(
      File.read("lib/assets/zip-codes-to-lat-lng.yml"),
    )

    @lat_lngs[zip_code]
  end

  def self.fetch_temperature(lat, lng)
    response = RestClient.get(api_url(lat, lng))

    JSON.parse(response)["currently"]["temperature"].round
  end

  def self.api_url(lat, lng)
    "#{BASE_API_URL}/#{Rails.application.credentials.dark_sky[:secret_key]}/#{lat},#{lng}"
  end

  private_class_method :zip_to_lat_lng, :fetch_temperature, :api_url

  class UnrecognizedZipCode < StandardError
    def initialize(message = nil)
      message ||= I18n.t(:unrecognized_zip_code_error)

      super(message)
    end
  end
end
