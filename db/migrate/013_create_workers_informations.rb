class CreateWorkersInformations < ActiveRecord::Migration
  def change
    create_table :workers_informations do |t|
      t.date :period                                   #- Дата сведения
      t.string  :worker_code, :limit => 5         #- табельный номер сотрудника
      t.string  :department_code, :limit => 3          # - цех сотрудника
      t.string  :position_code, :limit => 5            #- должность сотрудника
      t.string  :schedule_code, :limit => 3           #- код графика
      t.integer :grade                                 # - разряд сотрудника
      t.decimal :salary, :precision => 10, :scale => 2, :default => 0.0 #- Оклад 
      t.decimal :tariff, :precision => 10, :scale => 2, :default => 0.0 #- Тариф
      t.string  :status   #статус изменение записа сведение (Уволен, Изменен, ПриемНаРаботу)
    end
  end
end
