module WidgetsHelper
  
  def widget_chart(widget)
    holder_id = "widget_chart_#{widget.name}"
    holder = content_tag 'div', "", id: holder_id
    chart = chart_instance(widget).chart
    if chart.respond_to? :to_js
      chart = render_chart(chart , holder_id)
    end
    [holder, chart].join("\n").html_safe
  end
  
  def chart_instance(widget)
    chart_type = widget.chart_type? ? widget.chart_type : 'default'
    klass = BaseTable.chart_types[chart_type.to_sym] || BaseTable
    klass.new(widget)
  end

  def widget_table(widget)
    holder_id = "widget_table_#{widget.name}"
    holder = content_tag 'div', "", id: holder_id
    chart = render_chart BaseTable.new(widget).chart, holder_id
    [holder, chart].join("\n").html_safe
  end
  
end
