class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences, :id => false do |t|
      t.string :code, :limit => 4
      t.string :name
      t.boolean :holiday_or_dayoffwork

#      t.timestamps
    end
  end
end
