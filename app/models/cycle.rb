# encoding: utf-8

#t.integer :schedule_of_working_id, :null => false
#t.integer :day
#t.decimal :hour, :precision => 10, :scale => 2
#t.decimal :hour_night, :precision => 10, :scale => 2


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
