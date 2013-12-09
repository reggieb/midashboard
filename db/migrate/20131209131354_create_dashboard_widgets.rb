class CreateDashboardWidgets < ActiveRecord::Migration
  def change
    create_table :dashboard_widgets do |t|
      t.integer :dashboard_id
      t.integer :widget_id

      t.timestamps
    end
  end
end
