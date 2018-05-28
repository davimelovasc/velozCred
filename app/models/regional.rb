class Regional < ApplicationRecord
  belongs_to :agent_aux, optional: true
  has_many :agent_auxes

  validates :name, presence: true

end
