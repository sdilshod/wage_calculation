class CreateDateCountings < ActiveRecord::Migration
  def change
    create_table :date_countings do |t|
      t.integer :schedule_of_working_id, :null => false
      t.integer :session_number, :null => false
      t.integer :begin_date
      t.date    :counting_date
#      t.timestamps
    end
  end
end
