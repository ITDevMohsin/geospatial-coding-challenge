class CreateDigsiteInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :digsite_infos do |t|
      t.references :excavation_info, null: false, foreign_key: true
      t.string :lookup_by
      t.string :location_type
      t.string :subdivision
      t.string :address_state
      t.string :address_county
      t.string :address_place
      t.string :address_zip
      t.string :address_num
      t.string :address_street_prefix
      t.string :address_street_name
      t.string :address_street_type
      t.string :address_street_suffix
      t.string :near_street_state
      t.string :near_street_county
      t.string :near_street_place
      t.string :near_street_prefix
      t.string :near_street_name
      t.string :near_street_type
      t.string :near_street_suffix

      t.timestamps
    end
  end
end
