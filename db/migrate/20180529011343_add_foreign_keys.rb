class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_reference :agent_auxes, :regional, index: true, type: :bigint
    add_foreign_key :agent_auxes, :regionals

    add_reference :agent_auxes, :agent, index: true, type: :bigint
    add_foreign_key :agent_auxes, :agents

    add_reference :regionals, :agent_aux, index: true, type: :bigint
    add_foreign_key :regionals, :agent_auxes

    add_reference :daily_productions, :agent_aux, index: true, type: :bigint
    add_foreign_key :daily_productions, :agent_auxes

    add_reference :total_productions, :agent_aux, index: true, type: :bigint
    add_foreign_key :total_productions, :agent_auxes

    add_reference :total_productions, :segment, index: true, type: :bigint
    add_foreign_key :total_productions, :segments

    add_reference :total_productions, :year_month, index: true, type: :bigint
    add_foreign_key :total_productions, :year_months

  end
end
