# == Schema Information
#
# Table name: calculations
#
#  id           :integer          not null, primary key
#  period       :date             not null
#  worker_code  :string(5)        not null
#  date_begin   :date             not null
#  date_end     :date             not null
#  type_of_calc :string(255)      not null
#  summ         :decimal(10, 2)   default(0.0)
#

#	начисле́ние -	charge 	

#	начисле́ние на зарпла́ту -	charge on payroll 	

#	начисле́ние нало́га  -	tax charge

#	удержа́ние -	deduction

class Calculation < ActiveRecord::Base

  validates :period, :worker_code, :date_begin, :date_end,
            :type_of_calc, :presence => true

  validates :worker_code, :length => {:is => 5}, :format => {:with => /[0-9]/}
  validates :type_of_calc, :length => {:is => 3}, :format => {:with => /[0-9]/}

  attr_accessor :year_month

  after_initialize :get_year_month
  before_validation :fill_dates

  scope :charges_list, lambda {|worker_code, acc_period| 
     arr = where("period=? and worker_code=? and type_of_calc < '600'", acc_period,worker_code)
  }
  scope :deductions_list, lambda {|worker_code, acc_period| 
     where("period=? and worker_code=? and type_of_calc >= '600'", acc_period,worker_code)
  }

#  scope :total_sum_for_tax_charge,  where("period = ? and type_of_calc = '102'", AppConstant.account_period)
#         .group("worker_code") 


  MINIMAL_WAGE=62920.00
  
  #Class methods
    #wage charge by worked hour or day
    def self.charging workers_information
      return nil if workers_information.blank?
      result = []
      norm_hour_of_month = ScheduleOfWorking.norm_of_working_hour 
      acc_period = AppConstant.account_period
      workers_information.each do |e|
        h_d = TimeSheet.worked_hd_for e.worker_code, e.schedule_code
        result << {period: acc_period,
                   worker_code: e.worker_code,
                   date_begin: acc_period,
                   date_end: acc_period.at_end_of_month,
                   type_of_calc: "102",
                   summ: e.calc_wage(h_d, norm_hour_of_month[1]),
                   auto_reported: true,
                   day: !e.salary.blank? && e.salary != 0 ? h_d.day : 0,
                   hour: !e.salary.blank? && e.salary != 0 ? 0 : h_d.hour
                   }
      end
      
      transaction do
        begin
          self.delete_all("period = '#{AppConstant.account_period}' and auto_reported and type_of_calc < '600'")
          Calculation.create! result
        rescue Exception => e
          errors = true
        end
        raise ActiveRecord::Rollback if errors
      end
      true
    end
  
    #wage deduction by charged sum
    def self.deduction
      h = self.total_sum_for_tax_charge.sum(:summ)
      result = []
      acc_period = AppConstant.account_period
      h.each_key do |e|
        result << {period: acc_period,
                   worker_code: e,
                   date_begin: acc_period,
                   date_end: acc_period.at_end_of_month,
                   type_of_calc: "604",
                   summ: self.calculate_of_tax_charge(h[e]),
                   auto_reported: true
                   }
        
      end
      return nil if result.blank?
      transaction do
        begin
          self.delete_all("period = '#{AppConstant.account_period}' and auto_reported and type_of_calc >= '600'")
          Calculation.create! result
        rescue Exception => e
          errors = true
        end
        raise ActiveRecord::Rollback if errors
      end
      true

    end

    #gets sum for charging tax
    def self.total_sum_for_tax_charge  
      where("period = ? and type_of_calc = '102'", AppConstant.account_period).group("worker_code") 
    end

    #calculation of tax charge
    def self.calculate_of_tax_charge sum
      # На 01,01,2012 г по налоговому закону УзБР расчет подоходного налого считается по шкале
      # до 5 кратного размера минимального з\п 9%
      # с 5 до 10 кратного размера минимального з\п 16%
      # свыше 10 кратного размера минимального з\п 22%
      
      s = MINIMAL_WAGE*5
      if sum <= s
        result = sum*0.09
      else
        result = s*0.09
        s10 = MINIMAL_WAGE*10
        if sum <= s10
          result += (sum-s)*0.16
        else
          result += (s10-s)*0.16
          result += (sum-s10)*0.22
        end
      end   
      return 0 unless result
      result   
      
    end


  #----end of class methods


  #instance methods  

    def worker
      Worker.find_by_code worker_code
    end

  #--end of instance methods


  private

  def get_year_month
    if !date_begin.blank? && !date_end.blank?
      @year_month = (date_begin.year.to_s + date_end.month.to_s) 
    end
  end

  def fill_dates
    unless year_month.blank?
      self.date_begin = (year_month+"01").to_date
      self.date_end = (year_month+"01").to_date.at_end_of_month
    end
  end


end
