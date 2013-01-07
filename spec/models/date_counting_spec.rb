require 'spec_helper'

describe DateCounting do
  before(:each) do
    @schedule_05 = FactoryGirl.build :schedule_05
    @schedule_05.save
    @initial_date_of_filling = Date.parse("01.01.2011")
    @end_date_of_filling = Date.parse("31.12.2011")
  end

  describe "#get_initial_date_for_rolling(begin_date)" do
    it "should return initial date for rolling schedules cycle" do
      d_counting_obj = @schedule_05.date_of_countings[0]
      d_counting_obj.get_initial_date_for_rolling(@initial_date_of_filling).should == Date.parse("27.12.2010")
    end
  end

  describe "#roll_cycle(date_begin, date_end)" do
    it "should roll cycle and return array hash contained schedule information" do
      d_counting_obj = @schedule_05.date_of_countings[0]
      arr_info = d_counting_obj.roll_cycle(@initial_date_of_filling, @end_date_of_filling)
      zero_d = "0.00".to_d; eight_d = "8.25".to_d
      a_h_schedule_info = [
        {:date => Date.parse("15.08.2011"), :schedule_code => "051", :hour => eight_d, :night_time => zero_d},
        {:date => Date.parse("16.08.2011"), :schedule_code => "051", :hour => eight_d, :night_time => zero_d},
        {:date => Date.parse("17.08.2011"), :schedule_code => "051", :hour => eight_d, :night_time => zero_d},
        {:date => Date.parse("18.08.2011"), :schedule_code => "051", :hour => eight_d, :night_time => zero_d},
        {:date => Date.parse("19.08.2011"), :schedule_code => "051", :hour => "7.00".to_d, :night_time => zero_d},
        {:date => Date.parse("20.08.2011"), :schedule_code => "051", :hour => zero_d, :night_time => zero_d},
        {:date => Date.parse("21.08.2011"), :schedule_code => "051", :hour => zero_d, :night_time => zero_d},
      ]
      a_h_schedule_info.each {|e| arr_info.should be_include(e) }
    end
  end
end
