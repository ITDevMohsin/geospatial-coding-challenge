class ServiceArea < ApplicationRecord
  belongs_to :ticket

  has_many :additional_service_area_codes, dependent: :destroy

end
