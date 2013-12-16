
class BarGraph < BaseTable
  
  def chart     
    @chart||= GoogleVisualr::Interactive::ColumnChart.new(data_table, options)
  end

end
