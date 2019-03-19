require "minitest/autorun"
require "minitest/reporters"
require "vcr"
require "webmock/minitest"
require "dotenv"
Dotenv.load

require_relative "../lib/location_search"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "specs/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }
  # Don't leave our Slack token lying around in a cassette file.
  config.filter_sensitive_data("<LOCATIONIQ_TOKEN>") do
    ENV["LOCATIONIQ_TOKEN"]
  end
end
