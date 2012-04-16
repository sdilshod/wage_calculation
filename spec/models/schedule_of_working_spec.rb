# encoding: utf-8

# ScheduleOfWorking attributes
#t.string :schedule_code
#t.string :name
#
#DateCounting attributes
#t.integer :schedule_of_working_id, :null => false
#t.integer :session_number, :null => false
#t.integer :begin_date
#t.date    :counting_date

#Cycle attributes
#t.integer :schedule_of_working_id, :null => false
#t.integer :day
#t.decimal :hour, :precision => 10, :scale => 2
#t.decimal :hour_night, :precision => 10, :scale => 2


require 'spec_helper'
include ScheduleSupportHelper

describe ScheduleOfWorking do
  before(:each) do
    @schedule_of_working = new_schedule_obj
    @schedule_of_working.cycles_attributes=collection_of_cycles
    @schedule_of_working.date_of_countings_attributes=collection_date_of_countings
    @schedule_of_working.save
    
    @modifed_cycles_attr = convert_has_many_coll_to_hash(@schedule_of_working.cycles)
        
    @modifed_date_of_counting_attr = convert_has_many_coll_to_hash(@schedule_of_working.date_of_countings)
    
    @new_schedule_object = new_schedule_obj
    
    @schedule_06 = Factory.create(:schedule_06)
  end
  
  describe "#valid?" do

    describe "on save" do
      it "should get error if name or/and schedule code is blank" do
        @valid_name = ScheduleOfWorking.new(new_schedule_obj.attributes.except("name"))
        @valid_name.save
        @valid_name.errors[:name].should_not be_blank
        
        @valid_schedule_code = ScheduleOfWorking.new(new_schedule_obj.attributes.except("schedule_code"))
        @valid_schedule_code.save
        @valid_schedule_code.errors[:schedule_code].should_not be_blank
      end
      
      it "should get an error if cycles or/and date countings is empty" do
        @new_schedule_object.save
        @new_schedule_object.errors[:base].should be_include("Не заполнен цикл или дата отсчета графика")
      end
    end
    
  end
  
  describe "#cycles_attributes" do
    it "should build/update collections or delete them if _destroy is true" do
      @schedule_of_working.save
      @schedule_of_working.cycles.count.should == 7
      @schedule_of_working.date_of_countings.count.should == 1
      @schedule_of_working.should be_valid
      
      @schedule_of_working.cycles_attributes=convert_has_many_coll_to_hash(@schedule_of_working.cycles)
      @schedule_of_working.save
      @schedule_of_working.cycles.count.should == 7
      
      @schedule_of_working.cycles_attributes = convert_has_many_coll_to_hash(@schedule_of_working.cycles,2)
      @schedule_of_working.save
      @schedule_of_working.cycles.count.should == 5

      @schedule_of_working.cycles_attributes = convert_has_many_coll_to_hash(@schedule_of_working.cycles,nil,true)
      @schedule_of_working.save
      @schedule_of_working.cycles.count.should == 5
      
      @schedule_of_working.should be_valid
      
    end
  end
  
  describe "#date_of_countings_attributes" do
    it "should build/update collections or delete them if _destroy is true" do
      @schedule_of_working.save
      @schedule_of_working.date_of_countings.count.should == 1
      @schedule_of_working.should be_valid
      
    end  
  end 
  
  describe "#save" do
    it "should save schedule of working with valid data" do
      @schedule_of_working.errors.should be_blank
      @schedule_of_working.cycles(true).count.should == 7
      @schedule_of_working.date_of_countings(true).count.should == 1
    end

    it "should'n save schedule of working with invalid data" do
      @new_schedule_object.name = ""
      @new_schedule_object.save
      @new_schedule_object.errors[:name].should_not be_blank
      @new_schedule_object.errors[:base].should_not be_blank      
    end
    
  end
  
  describe ".fill_information_for(begin_date,end_date)" do
    it "should fill informations for all schedules in BD" do
      ScheduleOfWorking.fill_information_for("01.01.2011".to_date,"31.12.2011".to_date)
      ScheduleOfWorking.fill_information_for("01.01.2011".to_date,"31.12.2011".to_date)
      sch_work_count = SchOfWorkInformation.group(:schedule_code)
      ar=0; sch_work_count.each{|e| ar += 1}
      ar.should == 5
      sch_info_row = SchOfWorkInformation.where :date => "01.01.2011".to_date, :schedule_code => "051"
      sch_info_row.should_not be_blank
      sch_info_row[0].hour.should == "0.0".to_d
    end
  end

  describe ".classifiers_numbers(classifiers)" do
    it "should return option collections for select tag, contained <<schedule_code>>" do
      option_tags = ScheduleOfWorking.classifiers_numbers
      option_tags.should =~ /<option value='05'>/
    end

    it "should return option collections for select tag, contained <<schedule_code+date_of_counting.session_number>>" do
      option_tags = ScheduleOfWorking.classifiers_numbers false
      option_tags.should =~ /<option value='051'>/
    end
  end

end











