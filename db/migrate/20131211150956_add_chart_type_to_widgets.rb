class AddChartTypeToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :chart_type, :string
  end
end
