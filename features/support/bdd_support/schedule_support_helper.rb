# encoding: utf-8

module ScheduleSupportHelper
  #---------------------------------------
  # helper methods fo schedule model
  #---------------------------------------

  def collection_of_cycles
    collection=[]
    4.times { |t| collection << {:day=>t+1, :hour=>8.25, :night_time=>0.00} }
    collection <<{:day=>5, :hour=>7.00, :night_time=>0.00}
    2.times {|t| collection << {:day=>t+6, :hour=>0.00, :night_time=>0.00}}
    collection
  end

  def convert_has_many_coll_to_hash(collection, destroy_count=nil, with_blank_fields=false)
    n_arr = []
    collection.each do |e|
      n_arr << e.attributes.reject{|key, value| key == 'schedule_of_working_id'}
      unless destroy_count.blank?
        unless destroy_count == 0
          n_arr[collection.index(e)]['_destroy']=1
          destroy_count -= 1
        end
      end
    end
    n_arr << {'day'=>0, 'hour'=>0.00, 'night_time'=>0.00} if with_blank_fields
    n_arr
  end

  def collection_of_cycles_with_blank_fields
    collection=[]
    4.times { |t| collection << {:day=>t+1, :hour=>8.25, :night_time=>0.00} }
    collection <<{:day=>0, :hour=>0.00, :night_time=>0.00}
    2.times {|t| collection << {:day=>t+6, :hour=>0.00, :night_time=>0.00}}
    collection
  end


  def collection_date_of_countings
    collection = [{:session_number => 1, :initial_day => 2, :counting_date => Date.parse("01.04.1997")}]
  end

  def new_schedule_obj
    ScheduleOfWorking.new :schedule_code => "05", :name => "Дневной график"
  end

  #---------------------------------------------------
  # End of schedule
  #---------------------------------------------------

end
