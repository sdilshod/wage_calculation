# encoding: utf-8

#t.integer :schedule_of_working_id, :null => false
#t.integer :session_number, :null => false
#t.integer :initial_day
#t.date    :counting_date

class DateCounting < ActiveRecord::Base
#----associations----
  belongs_to :schedule_of_working

##----validations----
#  validates :session_number, :uniqueness => {:message => "в приделах этого графика не уникально"}, :if=>:around_schedule
  validates :initial_day, :counting_date, :presence => true
  validates :initial_day, :format => {:with => /[1-9]+/}


#instance methods

  def roll_cycle(date_begin, date_end)
    arr_schedule_info=[]
    initial_date = get_initial_date_for_rolling(date_begin)
    self.initial_day = 1
    
    while initial_date <= date_end
      
      if initial_date < date_begin
        initial_date += 1.day
        change_initial_day_of_cycle
        next
      end
      cycle_row = cycle.find_by_day self.initial_day

      hour = cycle_row.hour
      night_time = cycle_row.night_time
  
      #cheking initial date for holiday
      if holiday_value(initial_date) == initial_date
        hour = schedule_of_working.correct_holiday unless cycle_row.hour.blank?
        night_time = schedule_of_working.correct_holiday unless cycle_row.night_time.blank?
      elsif holiday_value(initial_date).class == Array
        hour = cycle_row.hour + schedule_of_working.precorrect_holiday
        night_time = cycle_row.night_time + schedule_of_working.precorrect_holiday
      end

      arr_schedule_info << {:date => initial_date, 
                            :schedule_code => schedule_of_working.schedule_code.to_s+self.session_number.to_s,
                            :hour => hour,
                            :night_time => night_time}
      initial_date += 1.day
      change_initial_day_of_cycle
    end
    arr_schedule_info
  end
  
  #incriment of attribute initial_day
  def change_initial_day_of_cycle
    if self.initial_day >= @cyclies_size
      self.initial_day = 1
    else
      self.initial_day += 1
    end
  end
  
  # gets initial date for rolling schedule cycle
  def get_initial_date_for_rolling(date_begin)
    @cyclies_size = cycle.count # Количество циклов графика
    cycles_begin_date = self.counting_date - (self.initial_day-1).day # начальный дата цикла для данной смены
    count_of_full_cycle = ((date_begin - cycles_begin_date)/@cyclies_size).to_int #количество полных циклов
    cycles_begin_date + count_of_full_cycle * @cyclies_size #дата первого дня цикла
  end

  def cycle
    schedule_of_working.cycles if schedule_of_working
  end

  def sch_code
    schedule_of_working.schedule_code + session_number.to_s if schedule_of_working
  end

  def holiday_value date
    #return date - holiday
    #return date, 1 - preholiday
    a = ScheduleOfWorking::HOLIDAYS
    return nil if a.blank?
    
    a.each do |e|
      if e[1] == date
        return date
        break
      elsif e[1] == date+1.day
        return date, 1
        break      
      end
    end

    return nil
  end

#---instance methods

#-----privats-----  
  private

#----validation methods----------
#  def around_schedule
#    schedule_of_working.date_of_countings.each do |e|
#      return true if e.session_number == self.session_number
#    end if schedule_of_working
#    false
#  end


end
