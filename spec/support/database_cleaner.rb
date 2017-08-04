require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    puts 'sets cleaner strategy to truncation'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    begin
    puts 'starts before suite cleaning'
      DatabaseCleaner.start
    puts 'starts before suite FactoryGirl lint'
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    puts 'carrying out before each spec clean'
    DatabaseCleaner.clean
  end

  config.after(:each) do
    puts 'carrying out after each spec clean'
    DatabaseCleaner.clean
  end
end
