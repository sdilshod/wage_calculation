class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers, :id => false do |t|
      t.string :code, :limit => 5
      t.string :name
    end
  end
end
