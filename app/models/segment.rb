class Segment < ApplicationRecord
  has_many :total_productions

  validates :segment, presence: true
end
