# encoding: utf-8

class ChargesController < ApplicationController

  def index
    @charges = Calculation.where("type_of_calc < '600'").order :period
  end  

  def new
    @charge = Calculation.new
  end

  def edit
    @charge = Calculation.find params[:id]
  end

  def update
    @charge = Calculation.find params[:id]
    if @charge.update_attributes params[:calculation]
      redirect_to charges_path
    else
      render :action => :edit
    end
  end

  def create
    @charge = Calculation.new params[:calculation]
    if @charge.save
      redirect_to charges_path
    else
      render :action => :new
    end
  end

  def destroy
    @charge = Calculation.find params[:id]
    if @charge
      @charge.destroy
    end
    redirect_to charges_path
  end

  def filling
    period = AppConstant.account_period
    worked_workers = WorkersInformation.get_workings_at(period.at_end_of_month)
    t_sh = TimeSheet.data_of_current_account_period

    if t_sh.blank?
      flash_message = "На дату #{period}, нет работающих сотрудников"
    elsif worked_workers.blank?
      flash_message = "На дату #{period}, не сформировано табель" 
    end

    if flash_message.blank?
      Calculation.charging worked_workers
      redirect_to charges_path
    else 
      flash[:notice] = flash_message
      index; render(:action => :index)
      return
    end
    
  end



end
