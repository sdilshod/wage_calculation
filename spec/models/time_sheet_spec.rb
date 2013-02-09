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

require 'spec_helper'

describe TimeSheet do
  before(:all) do
    @schedules = FactoryGirl.create :schedule_05
    @worker_24495 = FactoryGirl.create :worker_24495
    @worker_04620 = FactoryGirl.create :worker_04620
    @worker_07307 = FactoryGirl.create :worker_07307
    @department_068 = FactoryGirl.create :department_068
    @position_31022 = FactoryGirl.create :position_31022
    @position_10022 = FactoryGirl.create :position_10022
    @position_22610 = FactoryGirl.create :position_22610
    @account_period = CustomDBData.get_account_period
    ScheduleOfWorking.fill_information_for(:date_begin => @account_period,
                                           :date_end => @account_period.at_end_of_month)
    CustomDBData.data_of_workers_information.each do |e|
      WorkersInformation.create e
    end

    @workers = WorkersInformation.get_workings_at @account_period

  end

  #Заполнение табеля по умолчанию из графиков работы
  it ".fill_with_schedule" do
    TimeSheet.fill_with_schedule @workers
    TimeSheet.count.should == 3
  end

end


