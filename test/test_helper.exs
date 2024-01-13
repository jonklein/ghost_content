ExUnit.start()
ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")

Application.put_env(:ghost_content, :ghost_content,
  host: "https://my.ghost.host",
  api_key: "xyz123",
  version: "v5.0"
)
