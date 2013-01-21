class NewScheduleCol < ActiveRecord::Migration
  def up
    change_table :schedule_of_workings do |t|
      t.decimal :precorrect_holiday, :precision => 10, :scale => 2
      t.decimal :correct_holiday, :precision => 10, :scale => 2
    end
  end

  def down
    change_table :schedule_of_workings do |t|
      t.remove :precorrect_holiday, :correct_holiday
    end
  end
end
