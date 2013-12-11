
class TimeSeries < DataSeries
  def initialize(data, args = {})
    @data = data.collect{|d| d.to_f}
    @tight = args[:tight] || true
  end
  
  def labels(number = 6, &mod)
    if mod
      super {|l| mod.call Time.at(l)}
    else
      super {|l| Time.at(l)}
    end
  end
end
