class AddSeriesFieldsToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :x_times, :boolean
    add_column :widgets, :y_times, :boolean
    add_column :widgets, :x_points, :integer
    add_column :widgets, :y_points, :integer
  end
end
