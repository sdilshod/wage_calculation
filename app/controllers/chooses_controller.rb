class ChoosesController < ApplicationController

  layout 'modal_form'  
  before_filter :changed_element

  def workers
    @workers = Worker.order :code
  end  

  def shedule_of_workers
    @schedules = ScheduleOfWorking.schedules.sort
  end

  def absences
    @absences = Absence.order :code
  end

  private
  def changed_element
    @changed_el = params[:changed_el]
  end

end
