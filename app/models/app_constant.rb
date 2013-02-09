# encoding: utf-8
# == Schema Information
#
# Table name: app_constants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  const_type :string(255)
#  date_      :date
#  string_    :string(255)
#

#-------------------------------
class AppConstant < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true
  validates :const_type, :presence => true

#  validate :custom


  #class methods

  def self.create_methods
    m = all.map(&:name)
    #metaclass (class << self; self; end)
    (class << self; self; end).instance_eval do
      m.each do |method_name|
        define_method method_name.to_sym  do |const_value=false|
          o = find_by_name method_name
          unless const_value
            return o[o.const_type+"_"]
          end      
      
          if const_value.class.to_s == o.get_type_name    
            o[o.const_type+"_"] = const_value
            o.save
          end
        end
      end      
    end

  end

  #--end class defination

  # instance methods
  def get_type_name
    str=""
    self.const_type.split("_").each do |e|
      str << e.capitalize
    end
    return str
  end
  #----end of instance methods

end

AppConstant.create_methods



