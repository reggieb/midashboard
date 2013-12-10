class RedesignWidgets < ActiveRecord::Migration
  def change
    rename_column :widgets, :container, :x_field
    add_column    :widgets, :x_label,          :string
    add_column    :widgets, :y_field,          :string
    add_column    :widgets, :y_label,          :string
    add_column    :widgets, :before_parameter, :string
    add_column    :widgets, :after_parameter,  :string
    add_column    :widgets, :date_modifier,    :string
  end


end
