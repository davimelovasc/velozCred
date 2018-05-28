class DeviseTokenAuthCreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table(:agents) do |t|

      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      # t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, :default => 0, :null => false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name,               null: false
      t.string :key_j,              null: false, unique: true
      t.string :email,              null: false
      t.string :cpf,                null: false # limit: 11
      t.string :role,               null: false
      #t.string :uf,                 null: false # limit: 2
      #t.string :ctps_cda
      #t.float  :commission_percent
      #t.string :prefix            #limit: 6
      #t.string :account
      #t.string :account_type
      #t.float :extra
      #t.float :discount
      #t.float :vr_comis_account
      #t.date  :activity_start
      #t.boolean :cost_help
      #t.text :obs
      t.boolean :is_changed, default: false
      #t.references :regional, index: true, foreign_key: { to_table: :agents }


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
