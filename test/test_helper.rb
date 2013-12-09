ENV["RAILS_ENV"] = "test"
require 'webmock'
require 'webmock/minitest'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

I18n.enforce_available_locales = false

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

  def stringify_keys(hashes)
    if hashes.kind_of? Array
      hashes.each{|hash| stringify_keys(hash)}
    elsif hashes.kind_of? Hash
      hashes.keys.each{|k| hashes[k.to_s] = stringify_keys(hashes.delete(k))}
    end
    return hashes
  end

  def things
    @things ||= [
      {
        completeness: 0.9626948278806841,
        cost: "139.49",
        created_at: "2013-12-05T12:36:29Z",
        happened_at: "2013-03-19T12:36:29Z",
        id: 53,
        name: "foo",
        score: 9,
        updated_at: "2013-12-05T12:36:29Z"
      },
      {
        completeness: 0.45790931608150487,
        cost: "95.58",
        created_at: "2013-12-05T12:36:29Z",
        happened_at: "2012-12-08T12:36:29Z",
        id: 54,
        name: "bar",
        score: 0,
        updated_at: "2013-12-05T12:36:29Z"
      }
    ]
  end
end
