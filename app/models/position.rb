class Position < ActiveRecord::Base
  self.primary_key = "code"

  attr_accessible :code, :name


  validates :code, :presence => true, :uniqueness => true,
                   :length => {:is => 5}, :format => {:with => /[0-9]/}

  validates :name, :presence => true

end
