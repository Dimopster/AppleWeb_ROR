ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver :selenium_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu window-size=1920,1080] }
  )

  Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        desired_capabilities: capabilities
    )
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class Minitest::Test
    include Capybara::DSL
end
