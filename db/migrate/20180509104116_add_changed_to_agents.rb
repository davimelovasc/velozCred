class AddChangedToAgents < ActiveRecord::Migration[5.1]
  def change
    add_column :agents, :is_changed, :boolean, default: false
  end
end
