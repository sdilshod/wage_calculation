class SchOfWorkInformationsController < ApplicationController
  
  def index
    @sch_of_work_informations = SchOfWorkInformation.order :date
  end
  
  def new
    respond_to do |format|
      format.js do
        render :action => 'new'
      end
    end
  end

  def show
    respond_to do |f|
      f.js do
        @sch_of_work_info = SchOfWorkInformation.find params[:id]
      end
    end
  end

  def create
    respond_to do |format|
      format.js do
        @sch_of_work_info = SchOfWorkInformation.new(params[:sch_of_work_information])
        @sch_of_work_info.save
      end
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      format.js do
        @sch_of_work_info = SchOfWorkInformation.find(params[:id])
        @sch_of_work_info.update_attributes params[:sch_of_work_information]
      end
    end
    
  end
  
  def destroy
    respond_to do |format|
      format.js do
        @sch_of_work_info = SchOfWorkInformation.find(params[:id])
        @sch_of_work_info.destroy
      end
    end
  end
  
end
