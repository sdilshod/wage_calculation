class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.date :period #- Отчетный период расчета з\п
      t.string :worker_code, :limit => 5 # - код сотрудника
      t.date :date_begin# - дата начало периода
      t.date :date_end #   - дата окончание периода
      t.string :absence_code #- код явок\неявок
      t.string :schedule_code #- код графика
      t.decimal :hour, :precision => 5, :scale => 2 #- часы всего
    end
  end
end
