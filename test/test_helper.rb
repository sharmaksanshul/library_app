ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  # include Devise::Test::ControllerHelpers
  # def is_logged_in?
  #   !session[:user_id].nil?
  # end

  # # Log in as a particular user.
  # def log_in_as(user)
  #   session[:user_id] = user.id
  # end

  # Add more helper methods to be used by all tests here...
end
