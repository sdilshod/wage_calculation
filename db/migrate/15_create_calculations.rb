class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.date :period, :null => false
      t.string :worker_code, :null => false, :limit => 5
      t.date :date_begin, :null => false
      t.date :date_end, :null => false
      t.string :type_of_calc, :null => false
      t.decimal :summ, :precision => 10, :scale => 2, :default => 0.0
    end
  end
end
