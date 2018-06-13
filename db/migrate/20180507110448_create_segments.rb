class CreateSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :segments do |t|
      t.string :segment,   null: false
      t.integer :cod_segment

      t.timestamps
    end
  end
end
