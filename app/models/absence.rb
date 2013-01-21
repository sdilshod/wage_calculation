#t.string :code, :limit => 4
#t.string :name
#t.boolean :holiday_or_dayoffwork

class Absence < ActiveRecord::Base

  self.primary_key = "code"

  attr_accessible :code, :name, :holiday_or_dayoffwork


  validates :code, :presence => true, :uniqueness => true,
                   :format => {:with => /[0-9]/}

  validates :name, :presence => true


end
