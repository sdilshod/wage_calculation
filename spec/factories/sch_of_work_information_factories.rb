# encoding: utf-8

# t.date :date, :null => false
# t.string :schedule_code, :null => false
# t.decimal :hour, :precision => 10, :scale => 2
# t.decimal :night_time, :precision => 10, :scale => 2

Factory.define :sch_info, :class => SchOfWorkInformation do |s|
  s.date "01.01.2011"
  s.schedule_code "051"
  s.hour 0
  s.night_time 0
end

Factory.define :sch_info_06, :class => SchOfWorkInformation do |s|
  s.date "01.01.2011"
  s.schedule_code "061"
  s.hour 0
  s.night_time 0
end

