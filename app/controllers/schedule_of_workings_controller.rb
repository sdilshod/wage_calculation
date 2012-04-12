# encoding: utf-8

class ScheduleOfWorkingsController < ApplicationController
  
  def index
		@schedules = ScheduleOfWorking.order(:schedule_code)
  end

	def new
	  @schedule_of_working = ScheduleOfWorking.new
	  @schedule_of_working.cycles.build
	  @schedule_of_working.date_of_countings.build
	  form_title "new"
	end
	
	def edit
	  @schedule_of_working = ScheduleOfWorking.find params[:id]
	  form_title "edit"
  end
	
	def create
	  @schedule_of_working = ScheduleOfWorking.new params[:schedule_of_working]
	  if @schedule_of_working.save
	    flash[:notice]="Новый график создан успешно"
	    redirect_to_index
    else
	    flash[:notice]="Ошибка в создание графика"
	    form_title 'new'
	    render :action => :new
    end
  end
  
  def update
    @schedule_of_working = ScheduleOfWorking.find params[:id]
    if @schedule_of_working.update_attributes(params[:schedule_of_working])
      flash[:notice] = "Обновление графика произведено успешно"
      redirect_to_index
    else
      #flash[:error]="ошибка в редактирование"
      form_title "edit"
      render :action => :edit
    end
  end
  
  def destroy
    @schedule_of_working = ScheduleOfWorking.find params[:id]
    @schedule_of_working.destroy
    flash[:notice] = "Выбранный график был удален успешно"
    redirect_to_index
  end
  
  def filling
    unless request.post?
        
    else
      if params[:date_begin].blank? || params[:date_end].blank?
        flash[:errors]="Не выбраны начальный и/или концывые даты заполнение графика"
        return
      end
      ScheduleOfWorking.fill_information_for(params[:date_begin].to_date,params[:date_end].to_date)
      redirect_to_index
    end
  end
  
  private
  
  def form_title(action)
    if action == "new"
      @title="Новый график" 
    elsif action == "edit"
      @title="Редактирование графика"
    else
      @title=""
    end
  end

  def redirect_to_index
    redirect_to :action => :index
  end    



 
end
