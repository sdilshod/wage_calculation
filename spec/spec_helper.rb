# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
#require File.expand_path("../../features/support/bdd_support/schedule_support_helper", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

#require "factory_girl"


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("features/support/bdd_support/*.rb")].each {|f| require f}
#Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  
  DatabaseCleaner.clean_with :truncation

  DatabaseCleaner.strategy = :transaction  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.color_enabled = true
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation #

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

module CustomDBData
  def self.data_of_workers_information
    
    [
      {
        period: "28.09.2012".to_date, worker_code: "24495", department_code: "068", position_code: "31022",
        schedule_code: "051", grade: 11, salary: 390450.00, status: 2 
      },
      {
        period: "01.12.2012".to_date, worker_code: "24495", department_code: "068", position_code: "31022",
        schedule_code: "051", grade: 11, salary: 390450.00, status: 2 
      },
      {
        period: "01.08.2012".to_date, worker_code: "04620", department_code: "068", position_code: "22610",
        schedule_code: "051", grade: 10, salary: 311850.00, status: 2 
      },
      {
        period: "01.12.2012".to_date, worker_code: "04620", department_code: "068", position_code: "22610",
        schedule_code: "051", grade: 10, salary: 311850.00, status: 2 
      },
      {
        period: "01.08.2012".to_date, worker_code: "07307", department_code: "068", position_code: "22610",
        schedule_code: "051", grade: 10, salary: 311850.00, status: 2 
      },
      {
        period: "01.12.2012".to_date, worker_code: "07307", department_code: "068", position_code: "22610",
        schedule_code: "051", grade: 10, salary: 311850.00, status: 2 
      }

    ]

  end
end





