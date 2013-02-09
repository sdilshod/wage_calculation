# == Schema Information
#
# Table name: workers
#
#  code :string(5)        primary key
#  name :string(255)
#


class Worker < ActiveRecord::Base
  self.primary_key = "code"

  attr_accessible :code, :name


  validates :code, :presence => true, :uniqueness => true,
                   :length => {:is => 5}, :format => {:with => /[0-9]/}

  validates :name, :presence => true

  has_many :time_sheets

end
