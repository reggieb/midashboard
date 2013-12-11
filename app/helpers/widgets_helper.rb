module WidgetsHelper
  
  def widget_chart(widget)
    chart = chart_instance(widget)
    content_tag('img', nil, src: chart.url)
  end
  
  def chart_instance(widget)
    klass = case widget.chart_type
    when 'line'
      LineGraph
    else
      ScatterGraph
    end
    klass.new(widget)
  end
  
end
