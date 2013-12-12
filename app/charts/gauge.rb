
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
