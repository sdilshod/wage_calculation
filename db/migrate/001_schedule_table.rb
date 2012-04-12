class ScheduleTable < ActiveRecord::Migration
  def up
    create_table :schedule_of_workings do |t|
      t.string :schedule_code
      t.string :name
    end
  end

  def down
    drop_table :schedule_of_workings
  end
end
