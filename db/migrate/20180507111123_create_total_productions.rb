class CreateTotalProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :total_productions do |t|
      t.references :segment, index: true, foreign_key: { to_table: :total_productions }
      t.references :year_month, index: true, foreign_key: { to_table: :total_productions }
      t.references :agent_aux, index: true, foreign_key: { to_table: :total_productions }

      t.float :goal
      t.float :production_value
      t.float :goal_percent
      t.float :remuneration
      t.float :remunaration_percent

      t.timestamps
    end
  end
end
