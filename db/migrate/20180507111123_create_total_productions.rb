class CreateTotalProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :total_productions do |t|
      t.integer :segment_id, foreign_key: true
      t.integer :agent_id, foreign_key: true
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
