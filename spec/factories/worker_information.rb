# encoding: utf-8

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worker_24495_information, :class => WorkersInformation do
    period "01.01.2013".to_date
    worker_code "24495"
    department_code  "068"
    position_code "10022"
    schedule_code "051"
    status 2
    salary 300000.00
  end
end
