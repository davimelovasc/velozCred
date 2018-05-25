class CreateAgentAuxes < ActiveRecord::Migration[5.1]
  def change
    create_table :agent_auxes do |t|

      t.string :name,               null: false
      t.string :key_j,              null: false
      t.string :role,               null: false
      t.string :uf,                 null: false # limit: 2
      t.string :ctps_cda
      t.float  :commission_percent
      t.string :prefix            #limit: 6
      t.string :account
      t.string :account_type
      t.float :extra
      t.float :discount
      t.float :vr_comis_account
      t.date  :activity_start
      t.boolean :cost_help
      t.text :obs
      t.integer :regional_id, foreign_key: true


      t.timestamps
    end
  end
end
