# encoding: utf-8

#t.string :schedule_code
#t.string :name


class ScheduleOfWorking < ActiveRecord::Base
  #assocations
  has_many :cycles, :dependent => :destroy
  has_many :date_of_countings, :class_name => "DateCounting", :dependent => :destroy
  
  accepts_nested_attributes_for :cycles, :allow_destroy => true, :reject_if => :reject_day_attr
  
  accepts_nested_attributes_for :date_of_countings, :allow_destroy => true, :reject_if => :reject_date_counting
  
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

#class methods
def self.fill_information_for(date_begin, date_end)
  sch = all
  sch.each do |e_sch|
    
    e_sch.date_of_countings.each do |d_counting|
      
      h_calculate = d_counting.roll_cycle(date_begin, date_end)

      transaction do
        SchOfWorkInformation.delete_all("(date >= '#{date_begin}' and date <= '#{date_end}') and schedule_code = #{d_counting.sch_code}")
        SchOfWorkInformation.create! h_calculate 
      end
    end
  end
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
