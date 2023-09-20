class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy
  has_one :service_area, dependent: :destroy
  has_one :excavation_info, dependent: :destroy

  accepts_nested_attributes_for :excavator
end
