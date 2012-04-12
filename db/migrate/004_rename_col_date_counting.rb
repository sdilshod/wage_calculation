class RenameColDateCounting < ActiveRecord::Migration
  def up
    rename_column :cycles, :hour_night, :night_time
    rename_column :date_countings, :begin_date, :initial_day
  end

  def down
    rename_column :date_countings, :initial_day, :begin_date
    rename_column :cycles, :night_time, :hour_night
  end
end
