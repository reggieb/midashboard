class PieChart < BaseTable
  def chart     
    @chart ||= GoogleVisualr::Interactive::PieChart.new(data_table, options)  
  end
  
  def rows
    @rows ||= sorted_frequencies.collect{|d| {c: d}}
  end
  
  def columns
    [ 
      { :id => 'A', :label => 'Frequency', :type => 'string' },
      { :id => 'B', :label => widget.y_label, :type => column_type(widget.y_times) },
    ]
  end
  
  def groups
    widget.y_data.group_by{|d| d}
  end
  
  def frequencies
    groups.to_a.collect{|p| [p[0].to_s, p[1].length]}
  end
  
  def sorted_frequencies
    frequencies.sort_by{|n| n[0]}.reverse
  end
  
  def options
    super.merge(legend: true, is3D: true, width: 500)
  end
end
