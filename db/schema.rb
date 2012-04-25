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

ActiveRecord::Schema.define(:version => 6) do

  create_table "cycles", :force => true do |t|
    t.integer "schedule_of_working_id",                                                 :null => false
    t.integer "day"
    t.decimal "hour",                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal "night_time",             :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "date_countings", :force => true do |t|
    t.integer "schedule_of_working_id", :null => false
    t.integer "session_number",         :null => false
    t.integer "initial_day"
    t.date    "counting_date"
  end

  create_table "sch_of_work_informations", :force => true do |t|
    t.date    "date",                                                          :null => false
    t.string  "schedule_code",                                                 :null => false
    t.decimal "hour",          :precision => 10, :scale => 2, :default => 0.0
    t.decimal "night_time",    :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "schedule_of_workings", :force => true do |t|
    t.string "schedule_code"
    t.string "name"
  end

end
