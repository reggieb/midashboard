require 'test_helper'

class ApiClientTest < ActiveSupport::TestCase

  def setup
    @uri = 'http://localhost:3001/things.json'
  end
    
  def test_response
    get_all
    assert_equal things.to_json, ApiClient.new(@uri).response.body
  end
  
  def test_response_with_uri
    get_all
    assert_equal things.to_json, ApiClient.new(URI(@uri)).response.body
  end

  def test_raw
    get_all
    assert_equal stringify_keys(things), ApiClient.new(@uri).json
  end

  def test_failure
    enable_mock_connection_failure @uri
    assert_raise ApiClientError do
      ApiClient.new(@uri).response
    end
  end

  def test_connection_error
    enable_mock_connection_error(@uri)
    assert_raise ApiClientError do
      ApiClient.new(@uri).response
    end
  end

  def get_all
    enable_mock @uri, things.to_json
  end

end
