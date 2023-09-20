class CreateServiceAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :service_areas do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :primary_service_area_code

      t.timestamps
    end
  end
end
