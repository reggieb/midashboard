class CreateDashboardGroups < ActiveRecord::Migration
  def change
    create_table :dashboard_groups do |t|
      t.string :name
      t.integer :groupable_id
      t.string :groupable_type
      t.integer :dashboard_id

      t.timestamps
    end
  end
end
