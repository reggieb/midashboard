
class LineGraph < BaseTable
  
  def chart     
    @chart||= GoogleVisualr::Interactive::LineChart.new(data_table, options)  
  end

end
