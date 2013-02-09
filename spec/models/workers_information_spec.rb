# encoding: utf-8
# == Schema Information
#
# Table name: workers_informations
#
#  id              :integer          not null, primary key
#  period          :date
#  worker_code     :string(5)
#  department_code :string(3)
#  position_code   :string(5)
#  schedule_code   :string(3)
#  grade           :integer
#  salary          :decimal(10, 2)   default(0.0)
#  tariff          :decimal(10, 2)   default(0.0)
#  status          :string(255)
#


require 'spec_helper'

describe WorkersInformation do
  before(:each) do
    @worker_24495 = FactoryGirl.build(:worker_24495)
    @worker_24495.save
    @worker_04620 = FactoryGirl.build(:worker_04620)
    @worker_04620.save
    @worker_07307 = FactoryGirl.build(:worker_07307)
    @worker_07307.save
    @department_068 = FactoryGirl.build(:department_068)
    @department_068.save
    @position_31022 = FactoryGirl.build(:position_31022)
    @position_31022.save

    @position_10022 = FactoryGirl.build(:position_10022)
    @position_10022.save
    @position_22610 = FactoryGirl.build(:position_22610)
    @position_22610.save
    r = FactoryGirl.build(:worker_24495_information).save
    CustomDBData.data_of_workers_information.each do |e|
      WorkersInformation.create e
    end
  end

  it "#custom_validation" do
    r = WorkersInformation.new(:period => "01.01.2013".to_date,
                               :worker_code => "24495",
                               :department_code => "068",
                               :position_code => @position_31022.code,
                               :schedule_code => "051",
                               :status => 2,
                               :salary => 390000)
    r.save
    r.errors[:base].grep(/Нарушение уникальности записи сведение/).should_not be_blank

    r.period = "02.01.2013".to_date; r.save
    r.errors.should be_blank

    r.worker_code = "12345"; r.save
    r.errors[:base].should be_include("Сотрудник с кодом 12345 не найдено в БД!")

    r.worker_code = "24495"
    r.department_code = "121"; r.save
    r.errors[:base].should be_include("Подразделения с кодом 121 не найдено в БД!")

    r.department_code = "068"
    r.position_code = "12345"; r.save
    r.errors[:base].should be_include("Должность с кодом 12345 не найдено в БД!")

    r.position_code = "31022"
    r.tariff = 1200.00; r.save
    r.errors[:base].should be_include("Не может быть установлено оклад и тариф!")

  end

  it "#get_workings_at" do
    WorkersInformation.get_workings_at("31.12.2012".to_date).size.should == 3
  end


end
