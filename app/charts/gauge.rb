
class Gauge
  attr_reader :widget

  def initialize(widget)
    @widget = widget
  end

  def chart     
    @chart ||= GoogleVisualr::Interactive::Gauge.new(data_table, options)  
  end

  def data_table
    @data_table ||= build_data_table
  end

  def build_data_table
    table = GoogleVisualr::DataTable.new
    table.new_column('string'  , 'Label')
    table.new_column('number'  , 'Value')
    table.add_rows(1)
    table.set_cell(0, 0, widget.y_label )
    table.set_cell(0, 1, (widget.y_data.first * 100).round(2))
    table
  end

  def options
    { 
      height: 200, 
      width: 200, 
      redFrom: 90, 
      redTo:100, 
      yellowFrom: 75, 
      yellowTo: 90, 
      minorTicks: 5
    }      
  end
  
end
# data_table = GoogleVisualr::DataTable.new
#  data_table.new_column('string'  , 'Label')
#  data_table.new_column('number'  , 'Value')
#  data_table.add_rows(3)
#  data_table.set_cell(0, 0, 'Memory' )
#  data_table.set_cell(0, 1, 80)
#  data_table.set_cell(1, 0, 'CPU'    )
#  data_table.set_cell(1, 1, 55)
#  data_table.set_cell(2, 0, 'Network')
#  data_table.set_cell(2, 1, 68)
# 
#  opts   = { :width => 400, :height => 120, :redFrom => 90, :redTo => 100, :yellowFrom => 75, :yellowTo => 90, :minorTicks => 5 }
#  @chart = GoogleVisualr::Interactive::Gauge.new(data_table, opts)
 