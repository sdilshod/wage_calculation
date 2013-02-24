# encoding: utf-8
#
# == Schema Information
#
# Table name: absences
#
#  code                  :string(4)        primary key
#  name                  :string(255)
#  holiday_or_dayoffwork :boolean
#

FactoryGirl.define do
  factory :absence_450, :class => Absence do
    code "450"
    name "Без содержания"
  end
end
