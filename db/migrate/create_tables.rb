class CreatePositions < ActiveRecord::Migration
  def change

    create_table "absences", :id => false, :force => true do |t|
      t.string  "code",                  :limit => 4
      t.string  "name"
      t.boolean "holiday_or_dayoffwork"

      t.index :code, :unique => true
    end

    create_table "cycles", :force => true do |t|
      t.integer "schedule_of_working_id", :null => false
      t.integer "day"
      t.decimal "hour",       :precision => 10, :scale => 2, :default => 0.0
      t.decimal "night_time", :precision => 10, :scale => 2, :default => 0.0

      t.index :schedule_of_working_id
    end

    create_table "date_countings", :force => true do |t|
      t.integer "schedule_of_working_id", :null => false
      t.integer "session_number",         :null => false
      t.integer "initial_day"
      t.date    "counting_date"

      t.index :schedule_of_working_id
    end

    create_table "departments", :id => false, :force => true do |t|
      t.string "code", :limit => 3
      t.string "name"

      t.index :code, :unique => true
    end

    create_table "positions", :id => false, :force => true do |t|
      t.string "code", :limit => 5
      t.string "name"

      t.index :code, :unique => true
    end

    create_table "sch_of_work_informations", :force => true do |t|
      t.date    "date",          :null => false
      t.string  "schedule_code", :null => false
      t.decimal "hour",          :precision => 10, :scale => 2, :default => 0.0
      t.decimal "night_time",    :precision => 10, :scale => 2, :default => 0.0

      t.index [:date, :schedule_code]
    end

    create_table "schedule_of_workings", :force => true do |t|
      t.string  "schedule_code"
      t.string  "name"
      t.decimal "precorrect_holiday", :precision => 10, :scale => 2
      t.decimal "correct_holiday",    :precision => 10, :scale => 2

      t.index :schedule_code, :unique => true
    end

    create_table "time_sheets", :force => true do |t|
      t.date    "period"
      t.string  "worker_code",   :limit => 5
      t.date    "date_begin"
      t.date    "date_end"
      t.string  "absence_code"
      t.string  "schedule_code"
      t.decimal "hour",   :precision => 5, :scale => 2

      t.index [:period, :worker_code, :schedule_code]
    end

    create_table "workers", :id => false, :force => true do |t|
      t.string "code", :limit => 5
      t.string "name"

      t.index :code, :unique => true
    end

    create_table "workers_informations", :force => true do |t|
      t.date    "period"
      t.string  "worker_code",     :limit => 5
      t.string  "department_code", :limit => 3
      t.string  "position_code",   :limit => 5
      t.string  "schedule_code",   :limit => 3
      t.integer "grade"
      t.decimal "salary",          :precision => 10, :scale => 2, :default => 0.0
      t.decimal "tariff",          :precision => 10, :scale => 2, :default => 0.0
      t.string  "status"

      t.index [:period, :worker_code, :department_code, :position_code, :schedule_code]
    end

  end
end
