
class ApiClientError < StandardError
  include Nesty::NestedError
end
