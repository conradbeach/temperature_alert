# frozen_string_literal: true

WebMock.stub_request(:get, %r{https://api.darksky.net/forecast/\w+/18.180555,-66.749961})
  .to_return(
    status: 200,
    body: File.read(
      File.join("spec", "fixtures", "dark_sky_puerto_rico_response.json"),
    ),
  )
