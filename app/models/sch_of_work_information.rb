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


class SchOfWorkInformation < ActiveRecord::Base
  #validates :date, :uniqueness => {:message => "дата сведение о графике не уникально"} #, :if=>:around_schedule
  #validates :schedule_code, :uniqueness => {:message => "дата сведение о графике не уникально"} #, :if=>:around_schedule
  validates :date, :schedule_code, :presence => true
  validates :schedule_code, :format => {:with => /[0-9]+/}, :length => {:is => 3}  
    # На потом надо подумать об графике шестедневки для отпусков. В коде графике может быть алфавитьный обозначение
  
  validate :customer_validate

#class methods
  
  #sum hour of schedule with given params
  def self.get_hour_by_schedule(range_or_arr_of_date, schedule_code)
    case range_or_arr_of_date.class.to_s
    when "Range"
      return select("sum(hour) as hour, count(hour) as day").
      where("date between ? and ? and schedule_code = \"#{schedule_code}\" and hour != 0",
          range_or_arr_of_date.first.strftime, range_or_arr_of_date.last.strftime).first
    when "Array"
      return select("sum(hour) as hour, count(hour) as day").
      where("date in(?) and schedule_code = \"#{schedule_code}\" and hour != 0",range_or_arr_of_date).first
    end
  end

  def self.get_for_time_sheet schedule_code
    acc_period = AppConstant.account_period
    arr = self.where("date between ? and ? and schedule_code='#{schedule_code}'",
                                          acc_period.strftime,acc_period.at_end_of_month.strftime).order(:date)
    a=[]
    arr.each do |e|
      a << {:date => e.date, :hour => e.hour}
    end
    return a
  end  

#------------


  def to_hash
    h = {
      :sch_of_work_information => {
        :date => date, :schedule_code => schedule_code, :hour => hour, :night_time => night_time
      }
    }
    return h
  end


  private

#- custome validation methods

  def customer_validate
    s = SchOfWorkInformation.where(:date => self.date, :schedule_code => self.schedule_code).first

    if !s.blank? && (new_record? || s.id != self.id)
      self.errors[:base] = "Запись не уникально!(date=#{self.date.to_s(:db)}, schedule_code=#{self.schedule_code})"
    end
    
    sch_number = schedule_code[0..1].blank? ? "0" : schedule_code[0..1]
    session_number = schedule_code[2].blank? ? "0" : schedule_code[2]
    s = ScheduleOfWorking.where("schedule_code='#{sch_number}'").
                          joins(:date_of_countings).
                          where("date_countings.session_number=#{session_number}")
    if s.blank?
      self.errors[:base] = "График - #{sch_number} со смены #{session_number} не найдено в БД"
    end
  end

#---end of custome validation methods


end
