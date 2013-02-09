class AutoReportColumn < ActiveRecord::Migration
  def up
    change_table :calculations do |t|
      t.boolean :auto_reported, :default => false
    end
  end

  def down
    remove_column :calculations, :auto_reported
  end
end
