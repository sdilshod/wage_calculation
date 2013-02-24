# encoding: utf-8
class DeductionsController < ApplicationController
  def index
    @deductions = Calculation.where("type_of_calc > '599'")
  end  

  def new
    @deduction = Calculation.new
  end

  def edit
    @deduction = Calculation.find params[:id]
  end

  def update
    @deductions = Calculation.find params[:id]
    if @charge.update_attributes params[:calculation]
      redirect_to deductions_path
    else
      render :action => :edit
    end
  end

  def create
    @deduction = Calculation.new params[:calculation]
    if @deduction.save
      redirect_to deductions_path
    else
      render :action => :new
    end
  end

  def destroy
    @deduction = Calculation.find params[:id]
    if @deduction
      @deduction.destroy
    end
    redirect_to deductions_path
  end

  def filling

    if Calculation.deduction
      redirect_to deductions_path
    else 
      flash[:notice] = "Удержание не выполнена"
      index; render(:action => :index)
      return
    end
    
  end


 
end




