# encoding: utf-8

class Reference::PositionsController < ApplicationController

  def index
    @positions = Position.order :code
  end  

  def new
    @position = Position.new
  end

  def edit
    @position = Position.find_by_code params[:id]
  end

  def update
    @position = Position.find_by_code params[:position][:code]
    if @position.update_attributes params[:position]
      redirect_to reference_positions_path
    else
      render :action => :edit
    end
  end

  def create
    @position = Position.new params[:position]
    if @position.save
      redirect_to reference_positions_path
    else
      render :action => :new
    end
  end

  def destroy
    @position = Position.find_by_code params[:id]
    if @position
      @position.destroy
    end
    redirect_to reference_positions_path
  end
  

end
