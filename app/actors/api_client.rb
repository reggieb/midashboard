class ApiClient

  attr_accessor :uri

  def initialize(uri)
    @uri = URI(uri)
  end

  def response
    @response ||= get_response
  end

  def json
    @json ||= JSON.parse response.body
  end

  private
  def get_response
    begin
      remote = Net::HTTP.get_response uri
    rescue
      raise_error("Error connecting to #{uri.to_s}")
    end
    raise_error("Failure connecting to #{uri.to_s}: #{remote.code} - #{remote.message}") unless remote.code_type == Net::HTTPOK
    return remote
  end

  def raise_error(msg)
    raise ApiClientError.new(msg)
  end

end
