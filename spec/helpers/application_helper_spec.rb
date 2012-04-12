# encoding: utf-8
require 'spec_helper'
include ScheduleSupportHelper

# Specs in this file have access to a helper object that includes
# the ScheduleOfWorkingsHelper. For example:
#
# describe ScheduleOfWorkingsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe ApplicationHelper do

  describe "#error_messages" do
    before(:each) do
      @schedule_of_working = new_schedule_obj
      @schedule_of_working.cycles.build collection_of_cycles
      @schedule_of_working.date_of_countings.build collection_date_of_countings
      @schedule_of_working.save
      
      @modifed_cycles_attr = convert_has_many_coll_to_hash(@schedule_of_working.cycles[0..5])
          
      @modifed_date_of_counting_attr = convert_has_many_coll_to_hash(@schedule_of_working.date_of_countings)
      
      @new_schedule_object = new_schedule_obj
    end


    it "should build contaner of errors if there exists" do
      @schedule_of_working.cycles[0].day = nil
      @schedule_of_working.name = ""
      @schedule_of_working.save
      error_contaner = helper.error_messages(@schedule_of_working)
      error_contaner.should match(/не может быть пустым/)
      error_contaner.should match(/<h2>#{I18n.t(:title_of_error_message)}<\/h2>/)
      error_contaner.should match("<div class='error_message'>")
    end

    it "return blank string if no errors" do
      @schedule_of_working.save
      helper.error_messages(@schedule_of_working).should be_blank
    end
  end

end


