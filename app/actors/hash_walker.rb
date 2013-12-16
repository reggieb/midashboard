
class HashWalker
  attr_reader :hash
  def initialize(hash)
    if hash.kind_of? Array
      @hash = hash.collect{|h| string_or_symbol_keys(h)}
    else
      @hash = string_or_symbol_keys(hash)
    end
  end

  def array(path, data = hash)
    elements = path.split('/')
    return data if elements.empty?
    case data
    when Array
      data.collect{|d| array(path, d)}.flatten.compact
    when Hash, ActiveSupport::HashWithIndifferentAccess
      first = elements.shift
      values = first == '*' ? data.values : data[first]
      array(elements.join('/'), values)
    else
      data
    end
  end

  def values(path)
    data = array(path)
    return data.values unless data.kind_of? Array
    data.collect{|d| d.values}.flatten
  end

  private
  def string_or_symbol_keys(hash)
    ActiveSupport::HashWithIndifferentAccess.new(hash)
  end
end
