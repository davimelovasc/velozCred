class CreateDailyProductions < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_productions do |t|
      #t.references :agent_aux, foreign_key: true, type: :integer

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

      t.string :n_one
      t.string :n_two
      t.string :n_three
      t.string :n_four
      t.string :n_five
      t.string :n_six
      t.string :n_seven
      t.string :n_eight
      t.string :n_nine
      t.string :n_ten
      t.string :n_eleven
      t.string :n_twelve
      t.string :n_thirteen
      t.string :n_fourteen
      t.string :n_fiveteen
      t.string :n_sixteen
      t.string :n_seventeen
      t.string :n_eighteen
      t.string :n_nineteen
      t.string :n_twenty
      t.string :n_twentyone
      t.string :n_twentytwo
      t.string :n_twentythree

      t.timestamps
    end
  end
end
