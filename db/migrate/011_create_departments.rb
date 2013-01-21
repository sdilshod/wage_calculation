class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments, :id => false do |t|
      t.string :code, :limit => 3
      t.string :name
    end
  end
end
