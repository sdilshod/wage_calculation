# encoding: utf-8

class Reference::DepartmentsController < ApplicationController
  
  def index
    @departments = Department.order :code
  end  

  def new
    @department = Department.new
  end

  def edit
    @department = Department.find_by_code params[:id]
  end

  def update
    @department = Department.find_by_code params[:department][:code]
    if @department.update_attributes params[:department]
      redirect_to reference_departments_path
    else
      render :action => :edit
    end
  end

  def create
    @department = Department.new params[:department]
    if @department.save
      redirect_to reference_departments_path
    else
      render :action => :new
    end
  end

  def destroy
    @department = Department.find_by_code params[:id]
    if @department
      @department.destroy
    end
    redirect_to reference_departments_path
  end
  
end
