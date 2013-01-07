# encoding: utf-8

# t.date :date, :null => false
# t.string :schedule_code, :null => false
# t.decimal :hour, :precision => 10, :scale => 2
# t.decimal :night_time, :precision => 10, :scale => 2

FactoryGirl.define do
  factory :sch_info, :class => SchOfWorkInformation do 
    date "01.01.2011"
    schedule_code "051"
    hour 0
    night_time 0
  end
end

FactoryGirl.define do
  factory :sch_info_06, :class => SchOfWorkInformation do
    date "01.01.2011"
    schedule_code "061"
    hour 0
    night_time 0
  end
end

