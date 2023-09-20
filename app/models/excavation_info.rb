class ExcavationInfo < ApplicationRecord
  belongs_to :ticket
  has_one :digsite_info, dependent: :destroy
end
