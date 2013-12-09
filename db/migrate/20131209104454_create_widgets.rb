class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :root_uri
      t.string :data_type
      t.string :container
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
