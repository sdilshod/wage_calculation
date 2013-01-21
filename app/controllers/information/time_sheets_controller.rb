# encoding: utf-8
#-------

class Information::TimeSheetsController < ApplicationController

  def index
    respond_to do |format|
      format.html {@t_sheets = TimeSheet.all}
      format.js {@worker = Worker.find_by_code params[:worker_id]}
    end
  end

  def new
    @t_sh = TimeSheet.new
  end

  def edit
    @t_sh = TimeSheet.find params[:id]
  end

  def update
    @t_sh = TimeSheet.find params[:id]
    if @t_sh.update_attributes params[:time_sheet]
      redirect_to information_time_sheets_path
    else
      render :action => :edit
    end
  end

  def create
    @t_sh = TimeSheet.new params[:time_sheet]
    if @t_sh.save
      redirect_to information_time_sheets_path
    else
      render :action => :new
    end
  end

  def destroy
    @t_sh = TimeSheet.find params[:id]
    if @t_sh
      @t_sh.destroy
    end
    redirect_to information_time_sheets_path
  end

end

