class AddCodRegionalToRegionals < ActiveRecord::Migration[5.1]
  def change
    add_column :regionals, :cod_regional, :integer, null: false, default: 0
  end
end
