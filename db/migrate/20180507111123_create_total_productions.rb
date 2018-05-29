class CreateTotalProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :total_productions do |t|
      #t.references :segment, foreign_key: true, type: :integer
      #t.references :year_month, foreign_key: true, type: :integer
      #t.references :agent_aux, foreign_key: true, type: :integer

      t.float :goal
      t.float :production_value
      t.float :goal_percent
      t.float :remuneration
      t.float :remunaration_percent

      t.timestamps
    end
  end
end
