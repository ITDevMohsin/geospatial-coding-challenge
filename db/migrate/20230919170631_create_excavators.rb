class CreateExcavators < ActiveRecord::Migration[7.0]
  def change
    create_table :excavators do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :company_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :type
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :field_contact_name
      t.string :field_contact_phone
      t.string :field_contact_email
      t.boolean :crew_onsite

      t.timestamps
    end
  end
end
