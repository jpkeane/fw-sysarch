# Start Coveralls coverage
require 'coveralls'
Coveralls.wear_merged!
SimpleCov.merge_timeout 3600
SimpleCov.add_filter('/spec/')

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  # Shoulda configuration
  Shoulda::Matchers.configure do |options|
    options.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
