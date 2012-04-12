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
