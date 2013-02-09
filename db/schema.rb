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

ActiveRecord::Schema.define(:version => 16) do

  create_table "absences", :id => false, :force => true do |t|
    t.string  "code",                  :limit => 4
    t.string  "name"
    t.boolean "holiday_or_dayoffwork"
  end

  create_table "app_constants", :force => true do |t|
    t.string "name"
    t.string "const_type"
    t.date   "date_"
    t.string "string_"
  end

  create_table "calculations", :force => true do |t|
    t.date    "period",                                                                       :null => false
    t.string  "worker_code",   :limit => 5,                                                   :null => false
    t.date    "date_begin",                                                                   :null => false
    t.date    "date_end",                                                                     :null => false
    t.string  "type_of_calc",                                                                 :null => false
    t.decimal "summ",                       :precision => 10, :scale => 2, :default => 0.0
    t.boolean "auto_reported",                                             :default => false
  end

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

  create_table "departments", :id => false, :force => true do |t|
    t.string "code", :limit => 3
    t.string "name"
  end

  create_table "positions", :id => false, :force => true do |t|
    t.string "code", :limit => 5
    t.string "name"
  end

  create_table "sch_of_work_informations", :force => true do |t|
    t.date    "date",                                                          :null => false
    t.string  "schedule_code",                                                 :null => false
    t.decimal "hour",          :precision => 10, :scale => 2, :default => 0.0
    t.decimal "night_time",    :precision => 10, :scale => 2, :default => 0.0
  end

  create_table "schedule_of_workings", :force => true do |t|
    t.string  "schedule_code"
    t.string  "name"
    t.decimal "precorrect_holiday", :precision => 10, :scale => 2
    t.decimal "correct_holiday",    :precision => 10, :scale => 2
  end

  create_table "time_sheets", :force => true do |t|
    t.date    "period"
    t.string  "worker_code",   :limit => 5
    t.date    "date_begin"
    t.date    "date_end"
    t.string  "absence_code"
    t.string  "schedule_code"
    t.decimal "hour",                       :precision => 5, :scale => 2
  end

  create_table "workers", :id => false, :force => true do |t|
    t.string "code", :limit => 5
    t.string "name"
  end

  create_table "workers_informations", :force => true do |t|
    t.date    "period"
    t.string  "worker_code",     :limit => 5
    t.string  "department_code", :limit => 3
    t.string  "position_code",   :limit => 5
    t.string  "schedule_code",   :limit => 3
    t.integer "grade"
    t.decimal "salary",                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal "tariff",                       :precision => 10, :scale => 2, :default => 0.0
    t.string  "status"
  end

end
