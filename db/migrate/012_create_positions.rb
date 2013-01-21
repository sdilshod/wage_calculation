class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions, :id => false do |t|
      t.string :code, :limit => 5
      t.string :name
    end
  end
end
