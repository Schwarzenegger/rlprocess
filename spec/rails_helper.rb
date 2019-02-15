ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require 'capybara/rspec'
require "selenium/webdriver"
require 'sidekiq/testing'
Sidekiq::Testing.fake!

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless no-sandbox]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome

Capybara.default_max_wait_time = 5
Capybara.server = :puma, { Silent: true }
Capybara.raise_server_errors = false

ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

if ENV["CC_TEST_REPORTER_ID"]
  require "simplecov"
  SimpleCov.start
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include SpecHelpers::ControllerHelpers
  config.include Rails.application.routes.url_helpers
  config.include Warden::Test::Helpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
