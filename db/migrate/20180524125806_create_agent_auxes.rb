class CreateAgentAuxes < ActiveRecord::Migration[5.1]
  def change
    create_table :agent_auxes do |t|

      #t.references :regional, foreign_key: true, type: :integer
      #t.references :agent, foreign_key: true, type: :integer

      t.string :name,               null: false
      t.string :key_j,              null: false, unique: true
      t.string :role,               null: false
      t.string :uf
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

      t.timestamps
    end
  end
end
