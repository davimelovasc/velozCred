class CreateRegionals < ActiveRecord::Migration[5.1]
  def change
    create_table :regionals do |t|
      t.integer :agent_id, foreign_key: true
      t.string :name,      null: false
      t.string :company

      t.timestamps
    end
  end
end
