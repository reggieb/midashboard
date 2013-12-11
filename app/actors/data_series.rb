
class DataSeries
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def x_max
    @x_max ||= x_data.max
  end

  def y_max
    @y_max ||= y_data.max
  end

  def x_min
    @x_min ||= x_data.min
  end

  def y_min
    @y_min ||= y_data.min
  end

  def x_data
    @x_data ||= data.collect &:first
  end

  def y_data
    @y_data ||= data.collect &:last
  end
end
