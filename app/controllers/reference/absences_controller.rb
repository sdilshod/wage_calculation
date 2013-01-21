# encoding: utf-8
class Reference::AbsencesController < ApplicationController

  def index
    @absences = Absence.order("code")
  end  

  def new
    @absence = Absence.new
  end

  def edit
    @absence = Absence.find_by_code params[:id]
  end

  def update
    @absence = Absence.find_by_code params[:absence][:code]
    if @absence.update_attributes params[:absence]
      redirect_to reference_absences_path
    else
      render :action => :edit
    end
  end

  def create
    @absence = Absence.new params[:absence]
    if @absence.save
      redirect_to reference_absences_path
    else
      render :action => :new
    end
  end

  def destroy
    @absence = Absence.find_by_code params[:id]
    if @absence
      @absence.destroy
    end
    redirect_to reference_absences_path
  end
  

end
