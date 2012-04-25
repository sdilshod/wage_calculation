# encoding: utf-8

# t.date :date, :null => false
# t.string :schedule_code, :null => false
# t.decimal :hour, :precision => 10, :scale => 2
# t.decimal :night_time, :precision => 10, :scale => 2


class SchOfWorkInformation < ActiveRecord::Base
  #validates :date, :uniqueness => {:message => "дата сведение о графике не уникально"} #, :if=>:around_schedule
  #validates :schedule_code, :uniqueness => {:message => "дата сведение о графике не уникально"} #, :if=>:around_schedule
  validates :date, :schedule_code, :presence => true
  validates :schedule_code, :format => {:with => /[0-9]+/}, :length => {:is => 3}  
    # На потом надо подумать об графике шестедневки для отпусков. В коде графике может быть алфавитьный обозначение
  
  validate :customer_validate

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
      self.errors[:base] = "График - #{sch_number} со смены #{session_number}), не найдено в БД"
    end
  end

#---end of custome validation methods


end
