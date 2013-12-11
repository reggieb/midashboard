
require 'google_chart'
class LineGraph
  attr_reader :widget

  def initialize(widget)
    @widget = widget
  end
  
  def url

    GoogleChart::ScatterChart.new('320x200', "Line Chart") do |lc|
      Rails.logger.info widget.data_grid
        lc.data "Trend 1", widget.data_grid, '0000ff'
        lc.show_legend = true
#        lc.axis :y, :range => [0,10], :color => 'ff00ff', :font_size => 16, :alignment => :center
#        lc.axis :x, :range => [135,137], :color => '00ffff', :font_size => 16, :alignment => :center
#        lc.grid :x_step => 100.0/6.0, :y_step => 100.0/6.0, :length_segment => 1, :length_blank => 0

#      lc.data "Trend 1", [[1,1], [2,2], [3,3], [4,4]], '0000ff'
#      lc.data "Trend 2", [[4,5], [2,2]], '00ff00'

      return lc.to_url
    end
  end

end
