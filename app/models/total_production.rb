class TotalProduction < ApplicationRecord
  belongs_to :segment
  belongs_to :agent

  validates :year_month, presence: true
end
