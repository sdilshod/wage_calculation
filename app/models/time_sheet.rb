# encoding: utf-8
# == Schema Information
#
# Table name: time_sheets
#
#  id            :integer          not null, primary key
#  period        :date
#  worker_code   :string(5)
#  date_begin    :date
#  date_end      :date
#  absence_code  :string(255)
#  schedule_code :string(255)
#  hour          :decimal(5, 2)
#

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

#  ACCOUNT_PERIOD = "01.12.2012".to_date
#-------------

# class methods

  #default filling of time sheet with worked workers
  def self.fill_with_schedule workers_info
    return nil if workers_info.blank?
    acc_period = AppConstant.account_period
    transaction do
      delete_all("period = '#{AppConstant.account_period}' and absence_code is null ")
      workers_info.each do |worker_info|
        create( :period => acc_period,
                :worker_code => worker_info.worker_code,
                :date_begin => worker_info.date > acc_period ? worker_info.date : acc_period,
                :date_end => acc_period.at_end_of_month, 
                :schedule_code => worker_info.schedule_code)              
      end
    end
    
  end

  #getting data of current account period
  def self.data_of_current_account_period worker_code=nil, absences=false
    sql_st = "period = ? "
    sql_st += " and worker_code='#{worker_code}'" if worker_code
    sql_st += " and absence_code is not null" if absences
    where(sql_st, AppConstant.account_period )
  end

  #returns factical workerd hour\day
  def self.worked_hd_for worker_code, schedule_code
#    acc_period = AppConstant.account_period
    t_s = self.where("worker_code = ? and absence_code is null").first
    shedule_hd = SchOfWorkInformation.get_hour_by_schedule((acc_period..acc_period.at_end_of_month), 
                                                           schedule_code)
    arr_of_absences = self.curr_acc_period_absence_dates(worker_code)
    arr_of_date = []; arr_of_absences.each{|e| arr_of_date << e[:date]}
    absence_hd = SchOfWorkInformation.get_hour_by_schedule(arr_of_date, schedule_code)
    unless absence_hd.hour.blank?
      shedule_hd.hour -= absence_hd.hour
      shedule_hd.day -= absence_hd.day 
    end

    return shedule_hd
  end

  #returns date with absence code hash of array
  #[{:date => '2012-12-01', :absence => '450'},......]
  def self.curr_acc_period_absence_dates worker_code
    absences = self.data_of_current_account_period(worker_code,true)
    arr_of_date =[]
    absences.each do |e|
      (e.date_begin..e.date_end).each{|e_date| arr_of_date << {:date => e_date, :hour => e.absence_code} }
    end
    arr_of_date
  end

  # report time_sheet for worker 
  # returns hash of arrays
  def self.report_for worker_code, schedule_code
    arr = self.curr_acc_period_absence_dates worker_code
    arr_sel = SchOfWorkInformation.get_for_time_sheet schedule_code

    #replacing
    arr_sel.map! do |e|
      seek_a = arr.select{|e_s| e_s[:date] == e[:date] }
      if !seek_a.blank?
        e=seek_a[0]
      else
        e
      end
    end

    res =[]    
    res << arr_sel[0..7]; res << arr_sel[8..15]; res << arr_sel[16..23]; res << arr_sel[24..-1]
    res.each do |e|
      e.each do |e2|
        date_style = "font-size:12px;padding:5px;text-align:center;"
        hour_style = "font-size:16px;padding:5px;text-align:center;"
        if e2[:hour] == 0 
          date_style += "color:red;"
          hour_style += "color:white;"
        elsif e2[:hour].to_f > 8.25
          date_style += "background-color:#CCC;"
          hour_style += "background-color:#CCC;"
        end
        e2[:date_style]=date_style
        e2[:hour_style]=hour_style
      end
    end
    return res
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
