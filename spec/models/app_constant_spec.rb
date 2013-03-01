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

require 'spec_helper'

describe AppConstant do
  before :all do
    AppConstant.create name: "account_period", const_type: "date", date_: "01.12.2012".to_date
  end

  after :all do
    AppConstant.delete_all
  end

  
  it ".create_methods" do
    AppConstant.create_methods
    AppConstant.methods.should be_include(:account_period)
    AppConstant.account_period.should == "01.12.2012".to_date
  end
end
