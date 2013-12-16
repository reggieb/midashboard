class Compactor < Array
  attr_accessor :other

  def average
    reduce(:+) / size.to_f
  end

  def compact_to!(other, method = :first)
    return if size <= other.size
    @other = other
    replace compact_groups.collect{|g| g.send(method) }
  end

  def compact_factor
    size / other.size.to_f
  end

  def compact_groups
    compact_intersects.collect{|i| self[(i - compact_factor)..(i - 1)]}
  end

  def compact_intersects
    (1..length).select{|x| x % compact_factor == 0}
  end

end
