# encoding: utf-8

class AccountJournalController < ApplicationController
  
  def index
    respond_to do |format|
      format.html
      format.js do |page|
        w_c = params[:worker_id]
        acc_p = params[:acc_period].to_date
        if w_c.blank? || acc_p.blank?
          render js: "alert('Сотрудник или месяц не выбран')"
          return
        end
        @worker = Worker.find_by_code w_c
        if @worker.blank?
          render js: "alert('Сотрудник или месяц не выбран')"
          return
        end
        @charges = Calculation.charges_list w_c, acc_p
        @charge_sum = @charges.sum(:summ)
        @deductions = Calculation.deductions_list w_c, acc_p
      end
    end
  end

  def report_time_sheet
    w_c = params[:worker_id]
    @acc_period = params[:acc_period].to_date
    if w_c.blank? || @acc_period.blank?
      render :text => "Не заполнен поля период или сотрудник"
      return
    end
    w_inf = WorkersInformation.get_workings_at @acc_period.at_end_of_month, w_c
    @worker = w_inf[0].worker
    @arr = TimeSheet.report_for w_c, w_inf[0].schedule_code
    render :layout => "modal_form"
  end

end
