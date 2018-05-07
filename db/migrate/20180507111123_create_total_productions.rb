class CreateTotalProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :total_productions do |t|
      t.references :segment, foreign_key: true
      t.references :agent, foreign_key: true
      t.date :year_month, null: false
      t.float :goal
      t.float :production_value
      t.float :goal_percent
      t.float :remuneration
      t.float :remunaration_percent

      t.timestamps
    end
  end
end
