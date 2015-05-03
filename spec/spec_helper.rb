ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  config.order = "random"
  config.color = true
  config.formatter = 'NyanCatFormatter'
  config.include FactoryGirl::Syntax::Methods
  config.include Mongoid::Matchers, :type => :model
  # config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end

FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

