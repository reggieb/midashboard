module WidgetsHelper
  
  def widget_chart(widget)
    holder_id = "widget_chart_#{widget.name}"
    holder = content_tag 'div', "", id: holder_id
    chart = render_chart chart_instance(widget).chart, holder_id
    [holder, chart].join("\n").html_safe
  end
  
  def chart_instance(widget)
    klass = BaseTable.chart_types[widget.chart_type.to_sym] || BaseTable
    klass.new(widget)
  end
  
end
