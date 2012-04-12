module ScheduleOfWorkingsHelper
  
  def render_single_partial_field(f,object,assocation)
    feild = f.fields_for assocation, object, :child_index =>"new_#{assocation}" do|builder|
      render assocation.to_s, :f => builder
    end
    escape_javascript(feild)
  end
  
end


