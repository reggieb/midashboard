class BaseTable
  
  def self.chart_types
    {
      grid:    self,
      scatter: ScatterGraph,
      line:    LineGraph,
      bar:     BarGraph,
      guage:   Gauge,
      table:   SimpleTable,
      pie:     PieChart
    }
  end
  
  attr_reader :widget

  def initialize(widget)
    @widget = widget
  end
  
  def chart     
    @chart ||= GoogleVisualr::Interactive::Table.new(data_table, options)  
  end
  
  def data_table   
    GoogleVisualr::DataTable.new({ cols: columns, rows: rows })
  end
  
  def options
    { 
      height: 300, 
      width: 600, 
      title: widget.title,
      hAxis: { title: widget.x_label},
      vAxis: { title: widget.y_label},
      legend: 'none' 
    }      
  end
  
  def rows
    @rows ||= widget.data.collect{|d| {c: d}}
  end
  
  def columns
    [ 
      { :id => 'A', :label => widget.x_label, :type => column_type(widget.x_times) },
      { :id => 'B', :label => widget.y_label, :type => column_type(widget.y_times) },
    ]
  end
  
  def column_type(times)
    times ? 'datetime' : 'number'
  end

end
