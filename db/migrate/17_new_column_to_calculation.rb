class NewColumnToCalculation < ActiveRecord::Migration
  def up
    change_table :calculations do |t|
      t.integer "day", :default => 0
      t.decimal "hour", :precision => 10, :scale => 2, :default => 0.0
    end
  end

  def down
    remove_column :calculations, :day, :hour
  end
end
