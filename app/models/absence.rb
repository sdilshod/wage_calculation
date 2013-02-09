# encoding: utf-8
#
# == Schema Information
#
# Table name: absences
#
#  code                  :string(4)        primary key
#  name                  :string(255)
#  holiday_or_dayoffwork :boolean
#

class Absence < ActiveRecord::Base

  self.primary_key = "code"

  attr_accessible :code, :name, :holiday_or_dayoffwork


  validates :code, :presence => true, :uniqueness => true,
                   :format => {:with => /[0-9]/}

  validates :name, :presence => true


end
