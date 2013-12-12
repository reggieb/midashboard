
class ScatterGraph < BaseTable
  
  def chart     
    @chart||= GoogleVisualr::Interactive::ScatterChart.new(data_table, options)  
  end

end
