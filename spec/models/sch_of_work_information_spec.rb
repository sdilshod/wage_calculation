# encoding: utf-8
# == Schema Information
#
# Table name: sch_of_work_informations
#
#  id            :integer          not null, primary key
#  date          :date             not null
#  schedule_code :string(255)      not null
#  hour          :decimal(10, 2)   default(0.0)
#  night_time    :decimal(10, 2)   default(0.0)
#


require 'spec_helper'

describe SchOfWorkInformation do
  before(:each) do
    @schedule_05 = FactoryGirl.build :schedule_05
    @schedule_06 = FactoryGirl.build :schedule_06
    @schedule_05.save; @schedule_06.save
    
    @sch_information = FactoryGirl.create(:sch_info)
  end
  
  
  describe "#valid?" do
    it "should validate for exists rows with same date and schedule_code" do
      n_hash = {:date => @sch_information.date, :schedule_code => "061"}
      s_i = SchOfWorkInformation.new n_hash; s_i.save
      s_i.errors.should be_blank      
      @sch_information.save
      @sch_information.errors.should be_blank

      @sch_information.schedule_code = "061"
      @sch_information.save
      @sch_information.errors[:base].should_not be_blank

      @sch_information.schedule_code = "051"
      @sch_information.save
      @sch_information.errors[:base].should be_blank

    end
    
    it "should validate for existing schedule_code and his session_number in DB" do
      @sch_info = SchOfWorkInformation.new({:date => "01.01.2011", :schedule_code => "065", :hour => 8.00})
      @sch_info.save
      @sch_info.errors[:base].should_not be_blank
      @sch_info.schedule_code = "064"; @sch_info.save; @sch_info.errors.should be_blank

      @sch_info = SchOfWorkInformation.new({:date => "01.01.2011", :schedule_code => "071", :hour => 8.00})
      @sch_info.save
      @sch_info.errors[:base].should_not be_blank
      
    end
    
    it "should validate format of schedule_code" do
      @sch_info = SchOfWorkInformation.new({:date => "01.01.2011", :schedule_code => "06", :hour => 8.00})
      @sch_info.save
      @sch_info.errors[:schedule_code].should_not be_blank
    end
  end
end


