# == Schema Information
#
# Table name: cycles
#
#  id                     :integer          not null, primary key
#  schedule_of_working_id :integer          not null
#  day                    :integer
#  hour                   :decimal(10, 2)   default(0.0)
#  night_time             :decimal(10, 2)   default(0.0)
#

require 'test_helper'

class CycleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
