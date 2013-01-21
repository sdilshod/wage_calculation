# encoding: utf-8

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :position_31022, :class => Position do
    code "31022"
    name "Администратор ЭДО"
  end

  factory :position_10022, :class => Position do
    code "10022"
    name "Программист"
  end

  factory :position_22610, :class => Position do
    code "22610"
    name "Начальник бюро"
  end
  

end
