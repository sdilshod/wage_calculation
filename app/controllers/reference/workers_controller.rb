# encoding: utf-8

class Reference::WorkersController < ApplicationController

  def index
    @workers = Worker.all
  end  

  def new
    @worker = Worker.new
  end

  def edit
    @worker = Worker.find_by_code params[:id]
  end

  def update
    @worker = Worker.find_by_code params[:worker][:code]
    if @worker.update_attributes params[:worker]
      redirect_to reference_workers_path
    else
      render :action => :edit
    end
  end

  def create
    @worker = Worker.new params[:worker]
    if @worker.save
      redirect_to reference_workers_path
    else
      render :action => :new
    end
  end

  def destroy
    @worker = Worker.find_by_code params[:id]
    if @worker
      @worker.destroy
    end
    redirect_to reference_workers_path
  end

end
