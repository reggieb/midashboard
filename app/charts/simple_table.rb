

class SimpleTable
  attr_reader :widget
  def initialize(widget)
    @widget = widget
  end

  def chart
    html = <<HTML
<table class="table">
  <tr>
    <td rowspan="#{widget.y_data.length}">#{widget.title} (#{widget.name})</td>
    <td>#{widget.y_label}</td>
    <td>#{widget.y_data.first}</td>
    <td>#{widget.description}</td>
  </tr>
</table>
HTML
    html.html_safe
  end
end
