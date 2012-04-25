class ChangeDefaultVal < ActiveRecord::Migration
  def up
    change_table :cycles do |c|
      c.change_default :hour, 0.0
      c.change_default :night_time, 0.0
    end

    change_table :sch_of_work_informations do |c|
      c.change_default :hour, 0.0
      c.change_default :night_time, 0.0
    end
  end

  def down
    change_table :cycles do |c|
      c.change_default :hour, nil
      c.change_default :night_time, nil
    end

    change_table :sch_of_work_informations do |c|
      c.change_default :hour, nil
      c.change_default :night_time, nil
    end

  end

end
