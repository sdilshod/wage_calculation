# encoding: utf-8
#
# == Schema Information
#
# Table name: departments
#
#  code :string(3)        primary key
#  name :string(255)
#

class Department < ActiveRecord::Base
  self.primary_key = "code"

  attr_accessible :code, :name


  validates :code, :presence => true, :uniqueness => true,
                   :length => {:is => 3}, :format => {:with => /[0-9]/}

  validates :name, :presence => true

end
