class Regional < ApplicationRecord
  belongs_to :agent, optional: true
  has_many :agents
  belongs_to :agent_aux, optional: true
  has_many :agent_auxes

  validates :name, presence: true

end
