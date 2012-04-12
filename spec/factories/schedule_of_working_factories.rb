# encoding: utf-8

#t.string :schedule_code
#t.string :name
 
 
Factory.define :schedule_051, :class => ScheduleOfWorking do |schedule|
    schedule.schedule_code "05"
    schedule.name "Дневной график"
end

Factory.define :schedule_05, :class => ScheduleOfWorking do |s|
  s.schedule_code "05"  
  s.name "Дневной график"
  h_cycles = [
    {:day => 1, :hour => 8.25, :night_time => 0},
    {:day => 2, :hour => 8.25, :night_time => 0},
    {:day => 3, :hour => 8.25, :night_time => 0},
    {:day => 4, :hour => 8.25, :night_time => 0},
    {:day => 5, :hour => 7.0, :night_time => 0},
    {:day => 6, :hour => 0, :night_time => 0},
    {:day => 7, :hour => 0, :night_time => 0}
  ]
  
  h_date_countings=[
    {:session_number => 1, :initial_day => 2, :counting_date => "01.04.1997"},
  ]
  
  s.after_build do |s|
    s.cycles.build h_cycles
    s.date_of_countings.build h_date_countings
  end

end

Factory.define :schedule_06, :class => ScheduleOfWorking do |s|
  s.schedule_code "06"
  s.name "Сменного персонала 4-X"
  
  h_cycles = [
    {:day => 1, :hour => 12.0, :night_time => 0},{:day => 2, :hour => 8.0, :night_time => 2},
    {:day => 3, :hour => 6.0, :night_time => 4},{:day => 4, :hour => 0.0, :night_time => 0}
  ]
  
  h_date_countings=[
    {:session_number => 1, :initial_day => 4, :counting_date => "01.04.1997"},
    {:session_number => 2, :initial_day => 2, :counting_date => "01.04.1997"},
    {:session_number => 3, :initial_day => 1, :counting_date => "01.04.1997"},
    {:session_number => 4, :initial_day => 3, :counting_date => "01.04.1997"}        
  ]
  
  s.after_build do |s|
    s.cycles.build h_cycles
    s.date_of_countings.build h_date_countings
  end
  
end


#t.integer :schedule_of_working_id, :null => false
#t.integer :day
#t.decimal :hour, :precision => 10, :scale => 2
#t.decimal :hour_night, :precision => 10, :scale => 2

#Factory.define :cycle do |c|
##  c.day 1
##  c.hour 8.25
#  c.hour_night 0.00
#end 


