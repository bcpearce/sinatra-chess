require_relative '../sinatra-chess'
require 'chess'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'

def app
  Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL, :type => :request
end

Capybara.app = app
