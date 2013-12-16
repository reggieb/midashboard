class AddCompactMethodsToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :x_compact_method, :string
    add_column :widgets, :y_compact_method, :string
  end
end
