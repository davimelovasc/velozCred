class CreateYearMonths < ActiveRecord::Migration[5.1]
  def change
    create_table :year_months do |t|
      t.string :year_month

      t.timestamps
    end
  end
end
