class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.integer :schedule_of_working_id, :null => false
      t.integer :day
      t.decimal :hour, :precision => 10, :scale => 2
      t.decimal :hour_night, :precision => 10, :scale => 2
#      t.timestamps
    end
  end
end
