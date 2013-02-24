# == Schema Information
#
# Table name: time_sheets
#
#  id            :integer          not null, primary key
#  period        :date
#  worker_code   :string(5)
#  date_begin    :date
#  date_end      :date
#  absence_code  :string(255)
#  schedule_code :string(255)
#  hour          :decimal(5, 2)
#


FactoryGirl.define do
  
  factory :t_sh_absence_24495, :class => TimeSheet do
    period "01.12.2012".to_date
    worker_code "24495"
    date_begin "25.12.2012".to_date
    date_end "28.12.2012".to_date
    absence_code "450"
    schedule_code "051"
  end

end
