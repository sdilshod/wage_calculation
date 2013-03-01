# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sch = ScheduleOfWorking.new(schedule_code: "05", name: "Дневной график", 
                            precorrect_holiday: -1, correct_holiday: 0)

sch.cycles.build([{day: 1, hour: 8.25},
                  {day: 2, hour: 8.25},
                  {day: 3, hour: 8.25},
                  {day: 4, hour: 8.25},
                  {day: 5, hour: 7.25},
                  {day: 6, hour: 0.00},
                  {day: 7, hour: 0.00} ])
sch.date_of_countings.build({session_number: 1, initial_day: 2, counting_date: "01.04.1987".to_date})

sch.save

Worker.create!([{code: "24495", name: "Саматов Дилшод"},
                {code: "04620", name: "Шукуров Каххор"},
                {code: "34872", name: "Ташева Дилфуза"}])

Department.create!([
  {code: "068", name: "ОАСУП"},
  {code: "129", name: "Ткация"}
])

Position.create!([{code: "32013", name: "Инженер программист"},
                  {code: "22610", name: "Начальник бюро"},
                  {code: "31022", name: "Администратор ЭДО"},
                  {code: "11111", name: "Приемщик сырья"}])

Absence.create!{code: "450", name: "Без содержания"}

WorkersInformation.create!([
  {period: "29.09.2012".to_date, worker_code: "24495", department_code: "068", position_code: "31022", schedule_code: "051", grade: 11, salary: 390000.00, status: "1"},
  {period: "01.08.2012".to_date, worker_code: "04620", department_code: "068", position_code: "22610", schedule_code: "051", grade: 10, salary: 350000.00, status: "1"},
  {period: "19.12.2012".to_date, worker_code: "34872", department_code: "129", position_code: "11111", schedule_code: "051", grade: 3, tariff: 604.30, status: "1"}
])

AppConstant.create!(name: "account_period", const_type: "date", date_: "01.12.2012".to_date)


