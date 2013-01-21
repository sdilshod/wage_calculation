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

    ScheduleOfWorking.fill_information_for(:date_begin => "01.12.2012",
                                           :date_end => "31.12.2012")
    CustomDBData.data_of_workers_information.each do |e|
      WorkersInformation.create e
    end

    @workers = WorkersInformation.get_workings_at "01.12.2012".to_date

  end

  #Заполнение табеля по умолчанию из графиков работы
  it ".fill_with_schedule" do
    TimeSheet.fill_with_schedule @workers
    TimeSheet.count.should == 3

    TimeSheet.data_of_current_account_period.each do |e|
      SchOfWorkInformation.get_hour_by_schedule(e.date_begin, e.date_end, e.schedule_code).should == 166.25
    end


  end

end


