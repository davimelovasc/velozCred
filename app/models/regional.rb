class Regional < ApplicationRecord
  belongs_to :manager, optional: true, class_name: "AgentAux", foreign_key: "agent_aux_id"
  has_many :agent_auxes

  validates :name, presence: true

end
