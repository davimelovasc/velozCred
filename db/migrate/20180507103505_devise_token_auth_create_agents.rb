class DeviseTokenAuthCreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|

      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## User Info
      t.string :name,               null: false
      t.string :key_j,              null: false, unique: true
      t.string :email,              null: false
      t.string :cpf,                null: false # limit: 11
      t.string :role,               null: false
      t.boolean :is_changed, default: false

      ## Tokens
      t.text :tokens

      t.timestamps
    end
    add_index :agents, :email,                unique: true
    add_index :agents, [:uid, :provider],     unique: true
    add_index :agents, :reset_password_token, unique: true
    # add_index :agents, :confirmation_token,   unique: true
    # add_index :agents, :unlock_token,       unique: true
  end
end
