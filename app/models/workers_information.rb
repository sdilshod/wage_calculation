# encoding: utf-8
# == Schema Information
#
# Table name: workers_informations
#
#  id              :integer          not null, primary key
#  period          :date
#  worker_code     :string(5)
#  department_code :string(3)
#  position_code   :string(5)
#  schedule_code   :string(3)
#  grade           :integer
#  salary          :decimal(10, 2)   default(0.0)
#  tariff          :decimal(10, 2)   default(0.0)
#  status          :string(255)
#

## encoding: utf-8
#-------------

#t.date :period                                   #- Дата сведения
#t.string  :worker_code, :limit => 5         #- табельный номер сотрудника
#t.string  :department_code, :limit => 3          # - цех сотрудника
#t.string  :position_code, :limit => 5            #- должность сотрудника
#t.integer :grade                                 # - разряд сотрудника
#t.decimal :salary, :precision => 10, :scale => 2 #- Оклад 
#t.decimal :tariff, :precision => 10, :scale => 2 #- Тариф
#t.integer  :status   #статус изменение записа сведение (Уволен, Изменен, ПриемНаРаботу)

class WorkersInformation < ActiveRecord::Base
  
  validates :period, :worker_code, :department_code, 
            :position_code, :status, :schedule_code, :presence => true

  validate :custom_validation

  belongs_to :worker, :foreign_key => "worker_code", :class_name => "Worker"
#                   :length => {:is => 5}, :format => {:with => /[0-9]/}

#Constants

  WORKERS_STATUS = [ ["ПриемНаРаботу","1"], ["Изменение","2"], ["Уволнение","3"] ]

#----------------------


  def self.get_workings_at(cut_period, worker_code=nil)
    str_sql = "true"
    str_sql += worker_code.blank? ? '' : " and last_row.worker_code='#{worker_code}'"
    select("workers_info.*")
      .from(self.select("Max(period) as period, worker_code")
         .where("period <= ? and status <> '3'",cut_period).group("worker_code")
      .as("last_row"))
      .joins("INNER JOIN workers_informations AS workers_info 
              ON workers_info.period=last_row.period and workers_info.worker_code=last_row.worker_code")
      .where(str_sql)

  end


#object methods
  def current_status_name
    WorkersInformation::WORKERS_STATUS.detect{|e| e[1] == status}[0]
  end

  def calc_wage h_d, norm_of_month
    if !salary.blank? && salary != 0
      return salary/norm_of_month*h_d.day
    else
      return tariff*h_d.hour
    end
    
  end
#---------------


#private

  private

  def custom_validation
    worker = Worker.find_by_code worker_code
    unless worker
      errors[:base] << "Сотрудник с кодом #{worker_code} не найдено в БД!"
      return
    end 

    department = Department.find_by_code department_code
    unless department
      errors[:base] << "Подразделения с кодом #{department_code} не найдено в БД!"
      return
    end 

    position = Position.find_by_code position_code
    unless position
      errors[:base] << "Должность с кодом #{position_code} не найдено в БД!"
      return
    end

    sch_number = schedule_code[0..1].blank? ? "0" : schedule_code[0..1]
    session_number = schedule_code[2].blank? ? "0" : schedule_code[2]
    s = ScheduleOfWorking.where("schedule_code='#{sch_number}'").
                          joins(:date_of_countings).
                          where("date_countings.session_number=#{session_number}")
    if s.blank?
      errors[:base] = "График - #{sch_number} со смены #{session_number}), не найдено в БД"
      return
    end
     
    info = WorkersInformation.where("period = ? and worker_code = ? ", period, worker_code)
    if !info.blank? && new_record?
      errors[:base] << "Нарушение уникальности записи сведение (период- #{period} таб№-#{worker_code})!"
      return
    end 

    if salary != 0 && tariff != 0
      errors[:base] << "Не может быть установлено оклад и тариф!" 
    end

    if status == "1"
      s = WorkersInformation.where("worker_code = ? and status = '1'", worker_code)
      if !s.blank? && new_record?
        errors[:base] << "У сотрудника уже есть документ о приеме!"         
      end
    end

    s = WorkersInformation.where("worker_code = ? and status = '3'", worker_code)
    unless s.blank?
      errors[:base] << "Cотрудник уже уволен с #{s.period.strftime}"
    end

    # надо проверить на наличия записи на приемНаРаботу. Не можить быть одному сотруднику два записи по ПриемНаРаботу.
    # Если у сотрудника есть запись о уволнение, то выводить ошибку
    
  end


end
