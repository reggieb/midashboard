
class DataSeries
  attr_reader :data, :tight
  
  def initialize(data, args = {})
    @data = data
    @tight = args[:tight]
  end

  def max
    @max ||= data.max
  end

  def min
    @min ||= data.min
  end
  
  def ceiling
    @ceiling ||= max.ceil
  end
  
  def floor
    @floor ||= tight ? min.floor : 0
  end
  
  def size
    @size ||= ceiling - floor
  end
  
  def percentage_factor
    @percentage_factor ||= 100.0 / (size)
  end
  
  def percentages
    @percentage ||= data.collect{|d| (d - floor) * percentage_factor}
  end
  
  def labels(number = 6, &modifier)
    mod = number - 1
    (0..mod).to_a.collect do |point| 
      label = (point * ((size)/mod.to_f)) + floor
      label = modifier.call label if modifier
      label
    end
  end

end
