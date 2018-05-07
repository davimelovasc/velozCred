class CreateSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :segments do |t|
      t.integer :ord_segment
      t.string :segment,   null: false

      t.timestamps
    end
  end
end
