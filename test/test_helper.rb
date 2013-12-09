ENV["RAILS_ENV"] = "test"
require 'webmock'
require 'webmock/minitest'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def enable_mock(url, body = '<body><h1>Something</h1><p>Else</p></body>')
    stub_request(:get, url).
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => body, :headers => {})
  end

  def enable_mock_connection_failure(url, status = 400)
    stub_request(:get, url).
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => status, :body => 'Whoops!', :headers => {})
  end

  def enable_mock_connection_error(url)
    stub_request(:get, url).to_raise(SocketError.new("Some connection error"))
  end
end
