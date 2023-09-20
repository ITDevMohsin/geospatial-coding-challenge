class DigsiteInfo < ApplicationRecord
  belongs_to :excavation_info
  has_many :intersections, dependent: :destroy
  has_one :well_known_text, dependent: :destroy
end
