ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails env is running in production mode!') if Rails.env.production?
abort('The Rails env is running in development mode!') if Rails.env.development?

require 'rspec/rails'
require 'devise'
require 'capybara/rspec'
require 'support/recipes_helper'
require 'support/users_helper'
require 'support/products_helper'
require 'support/meals_helper'
require 'support/devise'
require 'spec_helper'
require 'money-rails/test_helpers'
require 'capybara/apparition'

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new(app, {js_errors: false})
end

Capybara.javascript_driver = :apparition

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Warden::Test::Helpers

  # Timeout.timeout(300) do
  #   loop until Webpacker.config.public_manifest_path.exist?
  # end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
