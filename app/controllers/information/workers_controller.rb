# encoding: utf-8
#-------

class Information::WorkersController < ApplicationController
  
  def index
    respond_to do |format|
      format.html {@workers = WorkersInformation.order :period}
      format.js {@worker = Worker.find_by_code params[:worker_id]}
    end
  end

  def new
    @worker = WorkersInformation.new
  end

  def edit
    @worker = WorkersInformation.find params[:id]
  end

  def update
    @worker = WorkersInformation.find params[:id]
    if @worker.update_attributes params[:workers_information]
      redirect_to information_workers_path
    else
      render :action => :edit
    end
  end

  def create
    @worker = WorkersInformation.new params[:workers_information]
    if @worker.save
      redirect_to information_workers_path
    else
      render :action => :new
    end
  end

  def destroy
    @worker = WorkersInformation.find params[:id]
    if @worker
      @worker.destroy
    end
    redirect_to information_workers_path
  end


end
