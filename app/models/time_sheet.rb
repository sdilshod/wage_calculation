# encoding: utf-8
#-------

#t.date :period #- Отчетный период расчета з\п
#t.string :worker_code, :limit => 5 # - код сотрудника
#t.date :date_begin# - дата начало периода
#t.date :date_end #   - дата окончание периода
#t.string :absence_code #- код явок\неявок
#t.string :schedule_code #- код графика
#t.decimal :hour, :precision => 5, :scale => 2 #- часы всего


class TimeSheet < ActiveRecord::Base
  
  validates :period, :worker_code, :date_begin, :date_end, :presence => true

  validates :worker_code, :format => {:with => /[0-9]/}

  validate :must_be_have

  belongs_to :worker, :foreign_key => "worker_code"
#Constants

  ACCOUNT_PERIOD = "01.12.2012".to_date
#-------------

# class methods
  def self.fill_with_schedule workers_info
    return nil if workers_info.blank?

    transaction do
      workers_info.each do |worker_info|
        create( :period => self::ACCOUNT_PERIOD,
                :worker_code => worker_info.worker_code,
                :date_begin => self::ACCOUNT_PERIOD,
                :date_end => self::ACCOUNT_PERIOD.at_end_of_month, 
                :schedule_code => worker_info.schedule_code)              
      end
    end
    
  end

  def self.data_of_current_account_period
    where("period between ? and ?", ACCOUNT_PERIOD, ACCOUNT_PERIOD.at_end_of_month)
  end
#-------------------

#object method
#--------------------




## Privates
  private
  
  #Custom validate method
  def must_be_have
    worker = Worker.find_by_code worker_code
    unless worker
      errors[:base] << "Сотрудник с кодом #{worker_code} не найдено в БД!"
      return
    end

    absence = Absence.find_by_code absence_code
    if absence.blank? and !absence_code.blank?
      errors[:base] << "Явка/Неявка с кодом #{absence_code} не найдено в БД!" 
      return
    end

    if !ScheduleOfWorking.schedules.include?(schedule_code) && !schedule_code.blank?
      errors[:base] << "График с кодом #{schedule_code} не найдено в БД!"
      return
    end

  end

end
