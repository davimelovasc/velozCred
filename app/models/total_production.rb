class TotalProduction < ApplicationRecord
  belongs_to :segment
  belongs_to :agent_aux
  belongs_to :year_month

end
