# == Schema Information
#
# Table name: calculations
#
#  id           :integer          not null, primary key
#  period       :date             not null
#  worker_code  :string(5)        not null
#  date_begin   :date             not null
#  date_end     :date             not null
#  type_of_calc :string(255)      not null
#  summ         :decimal(10, 2)   default(0.0)
#

require 'spec_helper'

describe Calculation do
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
      WorkersInformation.create! e
    end

    @workers = WorkersInformation.get_workings_at @account_period
  end

  after(:all) do
    @schedules.destroy
    Department.delete_all; Position.delete_all; WorkersInformation.delete_all; Worker.delete_all
  end

  it ".charging" do
    Calculation.charging nil
    Calculation.count.should == 0
    Calculation.charging @workers
    Calculation.count.should == 3   
    o = Calculation.where("period = ? and worker_code='24495' and type_of_calc < '600'", AppConstant.account_period).first.summ

    o.should == 597778.95
  end

  it ".deduction" do
    Calculation.charging @workers    
    Calculation.deduction
    Calculation.where("type_of_calc >= '600'").count.should > 1
  end

end
