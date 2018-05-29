class CreateRegionals < ActiveRecord::Migration[5.1]
  def change
    create_table :regionals do |t|

      #t.references :agent_aux, foreign_key: true, type: :integer
      t.string :name,      null: false
      t.integer :cod_regional, null: false, default: 0
      t.string :company


      t.timestamps
    end
  end
end
