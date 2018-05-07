class Regional < ApplicationRecord
  belongs_to :agent, optional: true
  has_many :agents

  validates :name, presence: true

end
