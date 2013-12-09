require 'test_helper'

class ApiClientTest < ActiveSupport::TestCase

  def setup
    @uri = 'http://localhost:3001/things.json'
  end
    
  def test_response
    get_all
    assert_equal things.to_json, ApiClient.new(@uri).response.body
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
