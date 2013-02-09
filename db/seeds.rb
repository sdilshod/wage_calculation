# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#sch = ScheduleOfWorking.new(:schedule_code => "05", :name => "Дневной график")

#sch.cycles.build([{:day => 1, :hour => 8.25},
#                  {:day => 2, :hour => 8.25},
#                  {:day => 3, :hour => 8.25},
#                  {:day => 4, :hour => 8.25},
#                  {:day => 5, :hour => 7.25},
#                  {:day => 6, :hour => 0.00},
#                  {:day => 7, :hour => 0.00} ])
#sch.date_of_countings.build({:session_number => 1, :initial_day => 4, :counting_date => "01.04.1987".to_date})

#sch.save

#Worker.create!([{:code => "24495", :name => "Саматов Дилшод"},
#                {:code => "04620", :name => "Шукуров Каххор"},
#                {:code => "07307", :name => "Хамидов Кодир"}])

Department.create!({code: "068", name: "ОАСУП"})
Position.create!({code: "32013", name: "Инженер программист"})
Position.create!({code: "22610", name: "Начальник бюро"})
Position.create!({code: "31022", name: "Администратор ЭДО"})




