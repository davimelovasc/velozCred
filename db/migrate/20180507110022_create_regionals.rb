class CreateRegionals < ActiveRecord::Migration[5.1]
  def change
    create_table :regionals do |t|
      t.references :agent, foreign_key: true, index: true
      t.string :name,      null: false
      t.string :company

      t.timestamps
    end
  end
end
