# encoding: utf-8
# == Schema Information
#
# Table name: schedule_of_workings
#
#  id                 :integer          not null, primary key
#  schedule_code      :string(255)
#  name               :string(255)
#  precorrect_holiday :decimal(10, 2)
#  correct_holiday    :decimal(10, 2)
#


#  precorrect_holiday :decimal(10, 2) надо сделать default: 0.0
#  correct_holiday    :decimal(10, 2) надо сделать default: 0.0


class ScheduleOfWorking < ActiveRecord::Base
  #assocations
  has_many :cycles, :dependent => :destroy
  has_many :date_of_countings, :class_name => "DateCounting", :dependent => :destroy
  
  accepts_nested_attributes_for :cycles, :allow_destroy => true, :reject_if => :reject_day_attr
  
  accepts_nested_attributes_for :date_of_countings, :allow_destroy => true, :reject_if => :reject_date_counting
  
  #attr_accessible :cycles_attributes, :date_of_countings_attributes
  
#---------------
#validations
#---------------
  
  #В версии рельсов 3,1 это валидация по умолчанию есть в has_many
  #validates_associated :cycles
  validates :schedule_code, :name, :presence => true, :uniqueness => true
  validates :schedule_code, :length => {:is => 2}  
  
  
  validate :must_be_cycles_or_date_countings  
    

#collbacks

#before_save :must_be_cycles_or_date_countings

#---collbacks

#Constants
  HOLIDAYS=[
    ["День конституции", "08.12.2012".to_date],
    ["Новый год", "01.01.2013".to_date],
    ["День женшинь", "08.03.2013".to_date]
   ]
#--------Constants

#class methods
  def self.fill_information_for(fill_information)
    
    date_begin          = fill_information[:date_begin].to_date
    date_end            = fill_information[:date_end].to_date
    classifier_schedule = fill_information[:classifier_schedule]
    schedule_number     = fill_information[:schedule_number]

    sch = all if classifier_schedule.blank? && schedule_number.blank?

    sch = [find_by_schedule_code(classifier_schedule)] if !classifier_schedule.blank?

    sch.each do |e_sch|
      
      e_sch.date_of_countings.each do |d_counting|
        
        next if !schedule_number.blank? && d_counting.sch_code != schedule_number
        
        h_calculate = d_counting.roll_cycle(date_begin, date_end)

        transaction do
          SchOfWorkInformation.delete_all("(date >= '#{date_begin}' and date <= '#{date_end}') and schedule_code = #{d_counting.sch_code}")
          
          SchOfWorkInformation.create! h_calculate 
        end
      end
    end
  end

  def self.schedules
    arr=[]
    all.each do |e|
      sch_c = e.schedule_code
      e.date_of_countings.each{ |d_counting| arr << sch_c.to_s+d_counting.session_number.to_s}
    end
    arr
  end

  def self.classifiers_numbers(classifiers=true, classifier_number=nil)
    option_tag="<option value='' selected> --- </option>"
  #  sch_of_works = classifier_number.blank? ? all : find_by_schedule_code(classifier_number)
  #  unless classifier_number.blank?
  #    e = find_by_schedule_code(classifier_number)
  #      sch_c = e.schedule_code
  #      e.date_of_countings.each do |d_counting|
  #        sch_number = sch_c.to_s+d_counting.session_number.to_s
  #        option_tag += "<option value='#{sch_number}'> #{sch_number} </option>"
  #      end
  #    return option_tag.html_safe
  #  end

    all.each do |e|
      sch_c = e.schedule_code
      if classifiers
        option_tag += "<option value='#{sch_c}'> #{sch_c.to_s} #{e.name} </option>"
      else
        e.date_of_countings.each do |d_counting|
          sch_number = sch_c.to_s+d_counting.session_number.to_s
          option_tag += "<option value='#{sch_number}'> #{sch_number} </option>"
        end
      end
    end

    option_tag.html_safe
  end

  #return date if it holiday.
  #return Array if it's pre holiday
  #else return nil
  def self.holiday_value date
    ScheduleOfWorking::HOLIDAYS.each do |e|
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

  #gets hour of norm for 40h working week for current account period
  # returned Array's first element hour and second is day 
  def self.norm_of_working_hour 
    period = AppConstant.account_period
    h = 0
    d = 0
    (1..period.at_end_of_month.day).each do |e|
      c_date = Date.new(period.year,period.month,e)
      next if self.holiday_value(c_date) == c_date || c_date.wday == 6 || c_date.wday == 0
      d += 1
      if c_date.wday == 5
        h += 7
      else
        h += 8.25
      end
      h -= 1 if self.holiday_value(c_date).class == Array
    end
    return h, d
  end



#---class methods  


#instance methods

  

#---instance methods



  private

#- custome validation methods

  def must_be_cycles_or_date_countings
    if cycles.blank? || date_of_countings.blank?
      str_message = "Не заполнен цикл или дата отсчета графика" 
      errors[:base] << str_message unless errors[:base].include?(str_message)
    end

    cycles.each do |e|
      if cycles.select{|x| x.day == e.day}.length > 1
        errors[:base] << "День цикла в приделах этого графика не уникально"
        break
      end
    end

    date_of_countings.each do |e|
      if date_of_countings.select{|x| x.session_number == e.session_number}.length > 1
        errors[:base] << "Номер смены в приделах этого графика не уникально"
        break
      end
    end

  end

#---end of custome validation methods

# Different methods for nested attributes

  def reject_day_attr(attr_)
    return true if attr_['day'].blank? || attr_['day'] == 0
    false
  end
  
  def reject_date_counting(attr_)
    if attr_[:session_number].blank? || attr_[:session_number] == 0 ||
       attr_[:initial_day].blank? || attr_[:initial_day] == 0 || attr_[:counting_date].blank?
      true
    else
      false
    end
  end
  

#--- End of different methods


end
