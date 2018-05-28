class AgentAux < ApplicationRecord
  belongs_to :agent, optional: true
  has_one :regional
  belongs_to :regional, optional: true
  has_many :total_productions
  has_one :daily_production

  validates :name, presence: true
  validates :key_j, presence: true, length: {is: 8}
  validates :role, presence: true

end
