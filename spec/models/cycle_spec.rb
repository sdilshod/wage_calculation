# == Schema Information
#
# Table name: cycles
#
#  id                     :integer          not null, primary key
#  schedule_of_working_id :integer          not null
#  day                    :integer
#  hour                   :decimal(10, 2)   default(0.0)
#  night_time             :decimal(10, 2)   default(0.0)
#

require 'spec_helper'

describe Cycle do
  
  before :each do
    @schedule_of_working = ScheduleOfWorking.new    
    @cycle = Cycle.new
  end
  
  it "correct assocations" do
    @schedule_of_working.has_attribute?("cycles") == true
    @cycle.has_attribute?("schedule_of_working") == true
  end

end
