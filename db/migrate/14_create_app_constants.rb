class CreateAppConstants < ActiveRecord::Migration
  def change
    create_table :app_constants do |t|
      t.string :name
      t.string :const_type
      t.date :date_
      t.string :string_
    end
    AppConstant.create name: "account_period", const_type: "date"

  end
end
