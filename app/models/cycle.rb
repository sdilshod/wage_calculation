# encoding: utf-8
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


class Cycle < ActiveRecord::Base
  belongs_to :schedule_of_working
  
  #-------------------
  #Validations
  #-------------------
  validates :day, :hour, :presence => true
#  validates :day, :uniqueness => {:message => "в приделах этого графика не уникально"}, :if=>:around_schedule
  

#privats  
  private

#----validation methods----
#  def around_schedule
#    schedule_of_working.cycles.each do |e|
#      return true if e.day == self.day
#    end if schedule_of_working
#    false
#  end



end
