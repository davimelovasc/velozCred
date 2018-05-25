class CreateDailyProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_productions do |t|
      t.integer :agent_id, foreign_key: true
      t.float :goal
      t.float :value
      t.float :miss
      t.float :miss_percent
      t.float :goal_du
      t.float :miss_du
      t.float :du_percent

      t.float :d_one
      t.float :d_two
      t.float :d_three
      t.float :d_four
      t.float :d_five
      t.float :d_six
      t.float :d_seven
      t.float :d_eight
      t.float :d_nine
      t.float :d_ten
      t.float :d_eleven
      t.float :d_twelve
      t.float :d_thirteen
      t.float :d_fourteen
      t.float :d_fiveteen
      t.float :d_sixteen
      t.float :d_seventeen
      t.float :d_eighteen
      t.float :d_nineteen
      t.float :d_twenty
      t.float :d_twentyone
      t.float :d_twentytwo
      t.float :d_twentythree

      t.integer :n_one
      t.integer :n_two
      t.integer :n_three
      t.integer :n_four
      t.integer :n_five
      t.integer :n_six
      t.integer :n_seven
      t.integer :n_eight
      t.integer :n_nine
      t.integer :n_ten
      t.integer :n_eleven
      t.integer :n_twelve
      t.integer :n_thirteen
      t.integer :n_fourteen
      t.integer :n_fiveteen
      t.integer :n_sixteen
      t.integer :n_seventeen
      t.integer :n_eighteen
      t.integer :n_nineteen
      t.integer :n_twenty
      t.integer :n_twentyone
      t.integer :n_twentytwo
      t.integer :n_twentythree

      t.timestamps
    end
  end
end
