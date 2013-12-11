
require 'google_chart'
class ScatterGraph
  attr_reader :widget

  def initialize(widget)
    @widget = widget
  end
  
  def url

    GoogleChart::ScatterChart.new('600x200', widget.title) do |lc|
      
        lc.data widget.y_label, widget.data, '0000ff'
        lc.show_legend = true
        lc.axis(
          :y, 
          labels: widget.y_series.labels{|l| format_label l}
        )
        lc.axis(
          :x, 
          labels: widget.x_series.labels{|l| format_label l}
        )

      return lc.to_url
    end
  end
  
  def format_label(label)
    label.kind_of?(Time) ? label.strftime("%d-%b-%Y") : label
  end

end
