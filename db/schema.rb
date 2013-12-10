# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131210083345) do

  create_table "dashboard_widgets", :force => true do |t|
    t.integer  "dashboard_id"
    t.integer  "widget_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "dashboards", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "root_uri"
    t.string   "data_type"
    t.string   "x_field"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "x_label"
    t.string   "y_field"
    t.string   "y_label"
    t.string   "before_parameter"
    t.string   "after_parameter"
    t.string   "date_modifier"
  end

end
