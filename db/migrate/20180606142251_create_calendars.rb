class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|

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
