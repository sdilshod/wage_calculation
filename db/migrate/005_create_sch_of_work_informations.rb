class CreateSchOfWorkInformations < ActiveRecord::Migration
  def change
    create_table :sch_of_work_informations do |t|
      t.date :date, :null => false
      t.string :schedule_code, :null => false
      t.decimal :hour, :precision => 10, :scale => 2
      t.decimal :night_time, :precision => 10, :scale => 2
#      t.timestamps
    end
  end
end
